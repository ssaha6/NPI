axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$##thread_id: $ctype;

axiom $def_math_type(^$##thread_id);

type $##thread_id;

const unique ^$##club: $ctype;

axiom $def_math_type(^$##club);

type $##club;

const unique ^s_node: $ctype;

axiom $is_span_sequential(^s_node);

axiom $def_struct_type(^s_node, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^s_node) } $inv2(#s1, #s2, #p, ^s_node) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2_without_lemmas(#s1, #s2, #p, ^s_node) } $inv2_without_lemmas(#s1, #s2, #p, ^s_node) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^s_node)) } $in(q, $composite_extent(s, p, ^s_node)) == (q == p));

const unique s_node.key: $field;

axiom $def_phys_field(^s_node, s_node.key, ^^i4, false, 0);

const unique s_node.next: $field;

axiom $def_phys_field(^s_node, s_node.next, $ptr_to(^s_node), false, 8);

const unique ^$#_purecall_handler#1: $ctype;

axiom $def_fnptr_type(^$#_purecall_handler#1);

type $#_purecall_handler#1;

const unique ^$#_invalid_parameter_handler#2: $ctype;

axiom $def_fnptr_type(^$#_invalid_parameter_handler#2);

type $#_invalid_parameter_handler#2;

const unique ^$#sls_merge.c..36263#3: $ctype;

axiom $def_fnptr_type(^$#sls_merge.c..36263#3);

type $#sls_merge.c..36263#3;

const unique ^$#_PtFuncCompare#4: $ctype;

axiom $def_fnptr_type(^$#_PtFuncCompare#4);

type $#_PtFuncCompare#4;

const unique ^$#_PtFuncCompare#5: $ctype;

axiom $def_fnptr_type(^$#_PtFuncCompare#5);

type $#_PtFuncCompare#5;

const unique ^$#_PtFuncCompare#6: $ctype;

axiom $def_fnptr_type(^$#_PtFuncCompare#6);

type $#_PtFuncCompare#6;

const unique ^$#_PtFuncCompare#7: $ctype;

axiom $def_fnptr_type(^$#_PtFuncCompare#7);

type $#_PtFuncCompare#7;

const unique ^$#_onexit_t#8: $ctype;

axiom $def_fnptr_type(^$#_onexit_t#8);

type $#_onexit_t#8;

function F##int_max(SP#x: int, SP#y: int) : int;

const unique cf##int_max: $pure_function;

axiom (forall SP#x: int, SP#y: int :: { F##int_max(SP#x, SP#y) } $in_range_i4(F##int_max(SP#x, SP#y)));

axiom $function_arg_type(cf##int_max, 0, ^^i4);

axiom $function_arg_type(cf##int_max, 1, ^^i4);

axiom $function_arg_type(cf##int_max, 2, ^^i4);

procedure #int_max(SP#x: int, SP#y: int) returns ($result: int);
  free ensures $in_range_i4($result);
  free ensures $result == F##int_max(SP#x, SP#y);
  free ensures $call_transition(old($s), $s);



function F##int_min(SP#x: int, SP#y: int) : int;

const unique cf##int_min: $pure_function;

axiom (forall SP#x: int, SP#y: int :: { F##int_min(SP#x, SP#y) } $in_range_i4(F##int_min(SP#x, SP#y)));

axiom $function_arg_type(cf##int_min, 0, ^^i4);

axiom $function_arg_type(cf##int_min, 1, ^^i4);

axiom $function_arg_type(cf##int_min, 2, ^^i4);

procedure #int_min(SP#x: int, SP#y: int) returns ($result: int);
  free ensures $in_range_i4($result);
  free ensures $result == F##int_min(SP#x, SP#y);
  free ensures $call_transition(old($s), $s);



function F#sll(#s: $state, SP#hd: $ptr) : bool;

const unique cf#sll: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#sll(#s, SP#hd) } 1 < $decreases_level ==> $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#sll(#s, SP#hd));

axiom $function_arg_type(cf#sll, 0, ^^bool);

axiom $function_arg_type(cf#sll, 1, $ptr_to(^s_node));

procedure sll(SP#hd: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result;
  free ensures $result == F#sll($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#srtl(#s: $state, SP#hd: $ptr) : bool;

const unique cf#srtl: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#srtl(#s, SP#hd) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#srtl(#s, SP#hd)) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> F#srtl(#s, SP#hd)));

axiom $function_arg_type(cf#srtl, 0, ^^bool);

axiom $function_arg_type(cf#srtl, 1, $ptr_to(^s_node));

procedure srtl(SP#hd: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result;
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> $result;
  free ensures $result == F#srtl($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#rsrtl(#s: $state, SP#hd: $ptr) : bool;

const unique cf#rsrtl: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#rsrtl(#s, SP#hd) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#rsrtl(#s, SP#hd)) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> F#rsrtl(#s, SP#hd)));

axiom $function_arg_type(cf#rsrtl, 0, ^^bool);

axiom $function_arg_type(cf#rsrtl, 1, $ptr_to(^s_node));

procedure rsrtl(SP#hd: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result;
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> $result;
  free ensures $result == F#rsrtl($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#sll_reach(#s: $state, SP#hd: $ptr) : $oset;

const unique cf#sll_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#sll_reach(#s, SP#hd) } 1 < $decreases_level ==> ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), F#sll_reach(#s, SP#hd))) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#sll_reach(#s, SP#hd) == $oset_empty()));

axiom $function_arg_type(cf#sll_reach, 0, ^$#oset);

axiom $function_arg_type(cf#sll_reach, 1, $ptr_to(^s_node));

procedure sll_reach(SP#hd: $ptr) returns ($result: $oset);
  ensures ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), $result)) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result == $oset_empty());
  free ensures $result == F#sll_reach($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#srtl_reach(#s: $state, SP#hd: $ptr) : $oset;

const unique cf#srtl_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#srtl_reach(#s, SP#hd) } 1 < $decreases_level ==> ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), F#srtl_reach(#s, SP#hd))) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#srtl_reach(#s, SP#hd) == $oset_empty()));

axiom $function_arg_type(cf#srtl_reach, 0, ^$#oset);

axiom $function_arg_type(cf#srtl_reach, 1, $ptr_to(^s_node));

procedure srtl_reach(SP#hd: $ptr) returns ($result: $oset);
  ensures ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), $result)) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result == $oset_empty());
  free ensures $result == F#srtl_reach($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#rsrtl_reach(#s: $state, SP#hd: $ptr) : $oset;

const unique cf#rsrtl_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#rsrtl_reach(#s, SP#hd) } 1 < $decreases_level ==> ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), F#rsrtl_reach(#s, SP#hd))) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#rsrtl_reach(#s, SP#hd) == $oset_empty()));

axiom $function_arg_type(cf#rsrtl_reach, 0, ^$#oset);

axiom $function_arg_type(cf#rsrtl_reach, 1, $ptr_to(^s_node));

procedure rsrtl_reach(SP#hd: $ptr) returns ($result: $oset);
  ensures ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), $result)) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result == $oset_empty());
  free ensures $result == F#rsrtl_reach($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#sll_keys(#s: $state, SP#hd: $ptr) : $intset;

const unique cf#sll_keys: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#sll_keys(#s, SP#hd) } 1 < $decreases_level ==> ($non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $intset_in($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node)), F#sll_keys(#s, SP#hd))) && ($is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#sll_keys(#s, SP#hd) == $intset_empty()));

axiom $function_arg_type(cf#sll_keys, 0, ^$#intset);

axiom $function_arg_type(cf#sll_keys, 1, $ptr_to(^s_node));

procedure sll_keys(SP#hd: $ptr) returns ($result: $intset);
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $intset_in($rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node)), $result);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result == $intset_empty();
  free ensures $result == F#sll_keys($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#sll_min_key(#s: $state, SP#hd: $ptr) : int;

const unique cf#sll_min_key: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#sll_min_key(#s, SP#hd) } 1 < $decreases_level ==> $in_range_i4(F#sll_min_key(#s, SP#hd)) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> F#sll_min_key(#s, SP#hd) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node))));

axiom $function_arg_type(cf#sll_min_key, 0, ^^i4);

axiom $function_arg_type(cf#sll_min_key, 1, $ptr_to(^s_node));

procedure sll_min_key(SP#hd: $ptr) returns ($result: int);
  free ensures $in_range_i4($result);
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> $result == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node));
  free ensures $result == F#sll_min_key($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#sll_max_key(#s: $state, SP#hd: $ptr) : int;

const unique cf#sll_max_key: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#sll_max_key(#s, SP#hd) } 1 < $decreases_level ==> $in_range_i4(F#sll_max_key(#s, SP#hd)) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> F#sll_max_key(#s, SP#hd) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node))));

axiom $function_arg_type(cf#sll_max_key, 0, ^^i4);

axiom $function_arg_type(cf#sll_max_key, 1, $ptr_to(^s_node));

procedure sll_max_key(SP#hd: $ptr) returns ($result: int);
  free ensures $in_range_i4($result);
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node)) ==> $result == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node));
  free ensures $result == F#sll_max_key($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#sll_list_len_next(#s: $state, SP#x: $ptr) : int;

const unique cf#sll_list_len_next: $pure_function;

axiom (forall #s: $state, SP#x: $ptr :: { F#sll_list_len_next(#s, SP#x) } 1 < $decreases_level ==> $in_range_nat(F#sll_list_len_next(#s, SP#x)) && ($non_null($phys_ptr_cast(SP#x, ^s_node)) ==> F#sll_list_len_next(#s, SP#x) > 0) && ($is_null($phys_ptr_cast(SP#x, ^s_node)) ==> F#sll_list_len_next(#s, SP#x) == 0));

axiom $function_arg_type(cf#sll_list_len_next, 0, ^^nat);

axiom $function_arg_type(cf#sll_list_len_next, 1, $ptr_to(^s_node));

procedure sll_list_len_next(SP#x: $ptr) returns ($result: int);
  free ensures $in_range_nat($result);
  ensures $non_null($phys_ptr_cast(SP#x, ^s_node)) ==> $result > 0;
  ensures $is_null($phys_ptr_cast(SP#x, ^s_node)) ==> $result == 0;
  free ensures $result == F#sll_list_len_next($s, SP#x);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : bool;

const unique cf#sll_lseg: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg(#s, SP#hd, SP#tl) == F#sll(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg(#s, SP#hd, SP#tl)) && (F#sll_lseg(#s, SP#hd, SP#tl) ==> $oset_disjoint(F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node)))) && (F#sll_lseg(#s, SP#hd, SP#tl) && F#sll(#s, $phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll(#s, $phys_ptr_cast(SP#hd, ^s_node)) && F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_reach(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_keys(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_list_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_list_len_next(#s, $phys_ptr_cast(SP#tl, ^s_node)))) && (F#sll_lseg(#s, SP#hd, SP#tl) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#hd, ^s_node) && !$oset_in($rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> F#sll_lseg(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $intset_singleton($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)))) && F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), 1)));

axiom $function_arg_type(cf#sll_lseg, 0, ^^bool);

axiom $function_arg_type(cf#sll_lseg, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg, 2, $ptr_to(^s_node));

procedure sll_lseg(SP#hd: $ptr, SP#tl: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $result ==> $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node)));
  ensures $result && F#sll($s, $phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SP#hd, ^s_node)) && F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_reach($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys($s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_keys($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_list_len_next($s, $phys_ptr_cast(SP#hd, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_list_len_next($s, $phys_ptr_cast(SP#tl, ^s_node)));
  ensures $result && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#hd, ^s_node) && !$oset_in($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> F#sll_lseg($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)))) && F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), 1);
  free ensures $result == F#sll_lseg($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#srtl_lseg(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : bool;

const unique cf#srtl_lseg: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#srtl_lseg(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#srtl_lseg(#s, SP#hd, SP#tl) == F#srtl(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#srtl_lseg(#s, SP#hd, SP#tl)) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#srtl_lseg(#s, SP#hd, SP#tl)) && (F#srtl_lseg(#s, SP#hd, SP#tl) ==> $oset_disjoint(F#srtl_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node)))) && (F#srtl_lseg(#s, SP#hd, SP#tl) && F#srtl(#s, $phys_ptr_cast(SP#tl, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_max_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) <= F#sll_min_key(#s, $phys_ptr_cast(SP#tl, ^s_node)) ==> F#srtl(#s, $phys_ptr_cast(SP#hd, ^s_node)) && F#srtl_reach(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#srtl_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#srtl_reach(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_keys(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_list_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_list_len_next(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_min_key(#s, $phys_ptr_cast(SP#hd, ^s_node)) == F#sll_lseg_min_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) && F#sll_max_key(#s, $phys_ptr_cast(SP#hd, ^s_node)) == F#sll_max_key(#s, $phys_ptr_cast(SP#tl, ^s_node))) && (F#srtl_lseg(#s, SP#hd, SP#tl) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && !$oset_in($rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_max_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) <= $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)) ==> F#srtl_lseg(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#srtl_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $intset_singleton($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)))) && F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), 1) && F#sll_lseg_min_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == F#sll_lseg_min_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_max_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))) && (F#srtl_lseg(#s, SP#hd, SP#tl) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#srtl_lseg(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#srtl_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_singleton($phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_singleton($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == 1 && F#sll_lseg_min_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_max_key(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))));

axiom $function_arg_type(cf#srtl_lseg, 0, ^^bool);

axiom $function_arg_type(cf#srtl_lseg, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#srtl_lseg, 2, $ptr_to(^s_node));

procedure srtl_lseg(SP#hd: $ptr, SP#tl: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#srtl($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $result ==> $oset_disjoint(F#srtl_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node)));
  ensures $result && F#srtl($s, $phys_ptr_cast(SP#tl, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_max_key($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) <= F#sll_min_key($s, $phys_ptr_cast(SP#tl, ^s_node)) ==> F#srtl($s, $phys_ptr_cast(SP#hd, ^s_node)) && F#srtl_reach($s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#srtl_reach($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys($s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_keys($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_list_len_next($s, $phys_ptr_cast(SP#hd, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_list_len_next($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_min_key($s, $phys_ptr_cast(SP#hd, ^s_node)) == F#sll_lseg_min_key($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) && F#sll_max_key($s, $phys_ptr_cast(SP#hd, ^s_node)) == F#sll_max_key($s, $phys_ptr_cast(SP#tl, ^s_node));
  ensures $result && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && !$oset_in($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_max_key($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) <= $rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)) ==> F#srtl_lseg($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#srtl_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $oset_singleton($phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)))) && F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), 1) && F#sll_lseg_min_key($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == F#sll_lseg_min_key($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_max_key($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node));
  ensures $result && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#srtl_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_singleton($phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_len_next($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == 1 && F#sll_lseg_min_key($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node)) && F#sll_lseg_max_key($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node));
  free ensures $result == F#srtl_lseg($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_reach(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : $oset;

const unique cf#sll_lseg_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_reach(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_reach(#s, SP#hd, SP#tl) == F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_reach(#s, SP#hd, SP#tl) == $oset_empty()) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), F#sll_lseg_reach(#s, SP#hd, SP#tl))));

axiom $function_arg_type(cf#sll_lseg_reach, 0, ^$#oset);

axiom $function_arg_type(cf#sll_lseg_reach, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_reach, 2, $ptr_to(^s_node));

procedure sll_lseg_reach(SP#hd: $ptr, SP#tl: $ptr) returns ($result: $oset);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $oset_empty();
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), $result);
  free ensures $result == F#sll_lseg_reach($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#srtl_lseg_reach(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : $oset;

const unique cf#srtl_lseg_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#srtl_lseg_reach(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#srtl_lseg_reach(#s, SP#hd, SP#tl) == F#srtl_reach(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#srtl_lseg_reach(#s, SP#hd, SP#tl) == $oset_empty()) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), F#srtl_lseg_reach(#s, SP#hd, SP#tl))));

axiom $function_arg_type(cf#srtl_lseg_reach, 0, ^$#oset);

axiom $function_arg_type(cf#srtl_lseg_reach, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#srtl_lseg_reach, 2, $ptr_to(^s_node));

procedure srtl_lseg_reach(SP#hd: $ptr, SP#tl: $ptr) returns ($result: $oset);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#srtl_reach($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $oset_empty();
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), $result);
  free ensures $result == F#srtl_lseg_reach($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_keys(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : $intset;

const unique cf#sll_lseg_keys: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_keys(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_keys(#s, SP#hd, SP#tl) == F#sll_keys(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_keys(#s, SP#hd, SP#tl) == $intset_empty()) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $intset_in($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node)), F#sll_lseg_keys(#s, SP#hd, SP#tl))));

axiom $function_arg_type(cf#sll_lseg_keys, 0, ^$#intset);

axiom $function_arg_type(cf#sll_lseg_keys, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_keys, 2, $ptr_to(^s_node));

procedure sll_lseg_keys(SP#hd: $ptr, SP#tl: $ptr) returns ($result: $intset);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_keys($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $intset_empty();
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $intset_in($rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node)), $result);
  free ensures $result == F#sll_lseg_keys($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_min_key(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : int;

const unique cf#sll_lseg_min_key: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_min_key(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> $in_range_i4(F#sll_lseg_min_key(#s, SP#hd, SP#tl)) && ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_min_key(#s, SP#hd, SP#tl) == F#sll_min_key(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_min_key(#s, SP#hd, SP#tl) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node))));

axiom $function_arg_type(cf#sll_lseg_min_key, 0, ^^i4);

axiom $function_arg_type(cf#sll_lseg_min_key, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_min_key, 2, $ptr_to(^s_node));

procedure sll_lseg_min_key(SP#hd: $ptr, SP#tl: $ptr) returns ($result: int);
  free ensures $in_range_i4($result);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_min_key($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node));
  free ensures $result == F#sll_lseg_min_key($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_max_key(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : int;

const unique cf#sll_lseg_max_key: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_max_key(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> $in_range_i4(F#sll_lseg_max_key(#s, SP#hd, SP#tl)) && ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_max_key(#s, SP#hd, SP#tl) == F#sll_max_key(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_max_key(#s, SP#hd, SP#tl) == $rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node))));

axiom $function_arg_type(cf#sll_lseg_max_key, 0, ^^i4);

axiom $function_arg_type(cf#sll_lseg_max_key, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_max_key, 2, $ptr_to(^s_node));

procedure sll_lseg_max_key(SP#hd: $ptr, SP#tl: $ptr) returns ($result: int);
  free ensures $in_range_i4($result);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_max_key($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#hd, ^s_node), ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node));
  free ensures $result == F#sll_lseg_max_key($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_len_next(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : int;

const unique cf#sll_lseg_len_next: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_len_next(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> $in_range_nat(F#sll_lseg_len_next(#s, SP#hd, SP#tl)) && ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_len_next(#s, SP#hd, SP#tl) == F#sll_list_len_next(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_len_next(#s, SP#hd, SP#tl) == 0) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_len_next(#s, SP#hd, SP#tl) > 0));

axiom $function_arg_type(cf#sll_lseg_len_next, 0, ^^nat);

axiom $function_arg_type(cf#sll_lseg_len_next, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_len_next, 2, $ptr_to(^s_node));

procedure sll_lseg_len_next(SP#hd: $ptr, SP#tl: $ptr) returns ($result: int);
  free ensures $in_range_nat($result);
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_list_len_next($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == 0;
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $result > 0;
  free ensures $result == F#sll_lseg_len_next($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



procedure merge(P#a: $ptr, P#b: $ptr) returns ($result: $ptr);
  requires F#srtl($s, $phys_ptr_cast(P#a, ^s_node));
  requires F#srtl($s, $phys_ptr_cast(P#b, ^s_node));
  requires $oset_disjoint(F#srtl_reach($s, $phys_ptr_cast(P#a, ^s_node)), F#srtl_reach($s, $phys_ptr_cast(P#b, ^s_node)));
  modifies $s, $cev_pc;
  ensures F#srtl($s, $phys_ptr_cast($result, ^s_node));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation merge(P#a: $ptr, P#b: $ptr) returns ($result: $ptr)
{
  var stmtexpr2#14: $ptr;
  var SL#a1: $ptr;
  var stmtexpr1#13: $state;
  var _dryad_S1#1: $state;
  var stmtexpr0#12: $state;
  var _dryad_S0#0: $state;
  var stmtexpr2#11: $ptr;
  var SL#b1: $ptr;
  var stmtexpr1#10: $state;
  var SL#_dryad_S1: $state;
  var stmtexpr0#9: $state;
  var SL#_dryad_S0: $state;
  var ite#3: bool;
  var ite#2: bool;
  var ite#1: bool;
  var loopState#0: $state;
  var stmtexpr0#8: $ptr;
  var SL#b0: $ptr;
  var stmtexpr0#7: $ptr;
  var SL#a0: $ptr;
  var L#res: $ptr;
  var L#last: $ptr;
  var stmtexpr1#16: $oset;
  var stmtexpr0#15: $oset;
  var res_srtl_reach#6: $oset;
  var res_srtl_reach#5: $oset;
  var SL#_dryad_G1: $oset;
  var SL#_dryad_G0: $oset;
  var local.a: $ptr;
  var local.b: $ptr;
  var #wrTime$2^3.3: int;
  var #stackframe: int;

  anon18:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^3.3, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$2^3.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^3.3, (lambda #p: $ptr :: false));
    // assume true
    // assume true
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct s_node* local.b; 
    // local.b := b; 
    local.b := $phys_ptr_cast(P#b, ^s_node);
    // struct s_node* local.a; 
    // local.a := a; 
    local.a := $phys_ptr_cast(P#a, ^s_node);
    //  --- Dryad annotated function --- 
    // _math \oset _dryad_G0; 
    // _math \oset _dryad_G1; 
    // _math \oset res_srtl_reach#5; 
    // res_srtl_reach#5 := srtl_reach(local.a); 
    call res_srtl_reach#5 := srtl_reach($phys_ptr_cast(local.a, ^s_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _math \oset res_srtl_reach#6; 
    // res_srtl_reach#6 := srtl_reach(local.b); 
    call res_srtl_reach#6 := srtl_reach($phys_ptr_cast(local.b, ^s_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _dryad_G0 := @_vcc_oset_union(res_srtl_reach#5, res_srtl_reach#6); 
    SL#_dryad_G0 := $oset_union(res_srtl_reach#5, res_srtl_reach#6);
    // _math \oset stmtexpr0#15; 
    // stmtexpr0#15 := _dryad_G0; 
    stmtexpr0#15 := SL#_dryad_G0;
    // _dryad_G1 := _dryad_G0; 
    SL#_dryad_G1 := SL#_dryad_G0;
    // _math \oset stmtexpr1#16; 
    // stmtexpr1#16 := _dryad_G1; 
    stmtexpr1#16 := SL#_dryad_G1;
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
    // struct s_node* last; 
    // struct s_node* res; 
    // assume ==>(@_vcc_ptr_neq_null(local.a), &&(@_vcc_mutable(@state, local.a), @writes_check(local.a))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(local.b), &&(@_vcc_mutable(@state, local.b), @writes_check(local.b))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.b, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.b, ^s_node));
    // res := (struct s_node*)@null; 
    L#res := $phys_ptr_cast($null, ^s_node);
    // assert sll_lseg(res, res); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume sll_lseg(res, res); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert srtl_lseg(res, res); 
    assert F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume srtl_lseg(res, res); 
    assume F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert sll_lseg(last, last); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assume sll_lseg(last, last); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assert srtl_lseg(last, last); 
    assert F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assume srtl_lseg(last, last); 
    assume F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assert sll_lseg(local.b, local.b); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assume sll_lseg(local.b, local.b); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assert srtl_lseg(local.b, local.b); 
    assert F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assume srtl_lseg(local.b, local.b); 
    assume F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assert sll_lseg(local.a, local.a); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assume sll_lseg(local.a, local.a); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assert srtl_lseg(local.a, local.a); 
    assert F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assume srtl_lseg(local.a, local.a); 
    assume F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
    assume true;
    // if (@_vcc_ptr_eq_null(local.a)) ...
    if ($is_null($phys_ptr_cast(local.a, ^s_node)))
    {
      anon1:
        // return local.b; 
        $result := $phys_ptr_cast(local.b, ^s_node);
        assume true;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon6:
        assume true;
        // if (@_vcc_ptr_eq_null(local.b)) ...
        if ($is_null($phys_ptr_cast(local.b, ^s_node)))
        {
          anon2:
            // return local.a; 
            $result := $phys_ptr_cast(local.a, ^s_node);
            assume true;
            assert $position_marker();
            goto #exit;
        }
        else
        {
          anon5:
            // assert @reads_check_normal((local.a->key)); 
            assert $thread_local($s, $phys_ptr_cast(local.a, ^s_node));
            // assert @reads_check_normal((local.b->key)); 
            assert $thread_local($s, $phys_ptr_cast(local.b, ^s_node));
            assume true;
            // if (<=(*((local.a->key)), *((local.b->key)))) ...
            if ($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)))
            {
              anon3:
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // res := local.a; 
                L#res := $phys_ptr_cast(local.a, ^s_node);
                // assert sll_lseg(res, res); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume sll_lseg(res, res); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert srtl_lseg(res, res); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume srtl_lseg(res, res); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert sll_lseg(last, last); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume sll_lseg(last, last); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert srtl_lseg(last, last); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume srtl_lseg(last, last); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert sll_lseg(local.b, local.b); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume sll_lseg(local.b, local.b); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert srtl_lseg(local.b, local.b); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume srtl_lseg(local.b, local.b); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert sll_lseg(local.a, local.a); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume sll_lseg(local.a, local.a); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assert srtl_lseg(local.a, local.a); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume srtl_lseg(local.a, local.a); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // struct s_node* a0; 
                // a0 := local.a; 
                SL#a0 := $phys_ptr_cast(local.a, ^s_node);
                // struct s_node* stmtexpr0#7; 
                // stmtexpr0#7 := a0; 
                stmtexpr0#7 := $phys_ptr_cast(SL#a0, ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg(local.a, *((local.a->next))), &&(sll_lseg(*((local.a->next)), *((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_lseg_reach(*((local.a->next)), *((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg_reach(local.a, *((local.a->next))), @_vcc_oset_union(sll_lseg_reach(*((local.a->next)), *((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg_keys(local.a, *((local.a->next))), @_vcc_intset_union(sll_lseg_keys(*((local.a->next)), *((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg_len_next(local.a, *((local.a->next))), unchecked+(sll_lseg_len_next(*((local.a->next)), *((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), @_vcc_ptr_neq_pure(*((local.a->next)), *((local.a->next)))), ==(sll_lseg_max_key(local.a, *((local.a->next))), @\int_max(*((local.a->key)), sll_lseg_max_key(*((local.a->next)), *((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), @_vcc_ptr_neq_pure(*((local.a->next)), *((local.a->next)))), ==(sll_lseg_min_key(local.a, *((local.a->next))), @\int_min(*((local.a->key)), sll_lseg_min_key(*((local.a->next)), *((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), @_vcc_ptr_neq_pure(*((local.a->next)), *((local.a->next)))), ==(srtl_lseg(local.a, *((local.a->next))), &&(&&(srtl_lseg(*((local.a->next)), *((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_lseg_reach(*((local.a->next)), *((local.a->next)))))), <=(*((local.a->key)), sll_lseg_min_key(*((local.a->next)), *((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(srtl_lseg_reach(local.a, *((local.a->next))), @_vcc_oset_union(srtl_lseg_reach(*((local.a->next)), *((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assert @reads_check_normal((local.a->next)); 
                assert $thread_local($s, $phys_ptr_cast(local.a, ^s_node));
                // local.a := *((local.a->next)); 
                local.a := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), &&(@_vcc_mutable(@state, local.a), @writes_check(local.a))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^s_node));
            }
            else
            {
              anon4:
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // res := local.b; 
                L#res := $phys_ptr_cast(local.b, ^s_node);
                // assert sll_lseg(res, res); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume sll_lseg(res, res); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert srtl_lseg(res, res); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume srtl_lseg(res, res); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert sll_lseg(last, last); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume sll_lseg(last, last); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert srtl_lseg(last, last); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume srtl_lseg(last, last); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert sll_lseg(local.b, local.b); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume sll_lseg(local.b, local.b); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert srtl_lseg(local.b, local.b); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume srtl_lseg(local.b, local.b); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert sll_lseg(local.a, local.a); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume sll_lseg(local.a, local.a); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assert srtl_lseg(local.a, local.a); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume srtl_lseg(local.a, local.a); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // struct s_node* b0; 
                // b0 := local.b; 
                SL#b0 := $phys_ptr_cast(local.b, ^s_node);
                // struct s_node* stmtexpr0#8; 
                // stmtexpr0#8 := b0; 
                stmtexpr0#8 := $phys_ptr_cast(SL#b0, ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg(local.b, *((local.b->next))), &&(sll_lseg(*((local.b->next)), *((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_lseg_reach(*((local.b->next)), *((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg_reach(local.b, *((local.b->next))), @_vcc_oset_union(sll_lseg_reach(*((local.b->next)), *((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg_keys(local.b, *((local.b->next))), @_vcc_intset_union(sll_lseg_keys(*((local.b->next)), *((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg_len_next(local.b, *((local.b->next))), unchecked+(sll_lseg_len_next(*((local.b->next)), *((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), @_vcc_ptr_neq_pure(*((local.b->next)), *((local.b->next)))), ==(sll_lseg_max_key(local.b, *((local.b->next))), @\int_max(*((local.b->key)), sll_lseg_max_key(*((local.b->next)), *((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), @_vcc_ptr_neq_pure(*((local.b->next)), *((local.b->next)))), ==(sll_lseg_min_key(local.b, *((local.b->next))), @\int_min(*((local.b->key)), sll_lseg_min_key(*((local.b->next)), *((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), @_vcc_ptr_neq_pure(*((local.b->next)), *((local.b->next)))), ==(srtl_lseg(local.b, *((local.b->next))), &&(&&(srtl_lseg(*((local.b->next)), *((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_lseg_reach(*((local.b->next)), *((local.b->next)))))), <=(*((local.b->key)), sll_lseg_min_key(*((local.b->next)), *((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(srtl_lseg_reach(local.b, *((local.b->next))), @_vcc_oset_union(srtl_lseg_reach(*((local.b->next)), *((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assert @reads_check_normal((local.b->next)); 
                assert $thread_local($s, $phys_ptr_cast(local.b, ^s_node));
                // local.b := *((local.b->next)); 
                local.b := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), &&(@_vcc_mutable(@state, local.b), @writes_check(local.b))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.b, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.b, ^s_node));
            }
        }
    }

  anon19:
    // var struct s_node* last
    // last := res; 
    L#last := $phys_ptr_cast(L#res, ^s_node);
    // assert sll_lseg(res, res); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume sll_lseg(res, res); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert srtl_lseg(res, res); 
    assert F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume srtl_lseg(res, res); 
    assume F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert sll_lseg(last, last); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assume sll_lseg(last, last); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assert srtl_lseg(last, last); 
    assert F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assume srtl_lseg(last, last); 
    assume F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
    // assert sll_lseg(local.b, local.b); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assume sll_lseg(local.b, local.b); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assert srtl_lseg(local.b, local.b); 
    assert F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assume srtl_lseg(local.b, local.b); 
    assume F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
    // assert sll_lseg(local.a, local.a); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assume sll_lseg(local.a, local.a); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assert srtl_lseg(local.a, local.a); 
    assert F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    // assume srtl_lseg(local.a, local.a); 
    assume F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
    loopState#0 := $s;
    assume true;
    while (true)
      invariant F#srtl($s, $phys_ptr_cast(local.a, ^s_node));
      invariant F#srtl($s, $phys_ptr_cast(local.b, ^s_node));
      invariant $oset_disjoint(F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)), F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)));
      invariant F#srtl($s, $phys_ptr_cast(L#res, ^s_node));
      invariant F#srtl($s, $phys_ptr_cast(L#last, ^s_node));
      invariant F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
      invariant $oset_disjoint(F#srtl_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)), F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)));
      invariant $oset_disjoint(F#srtl_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)), F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)));
      invariant $oset_disjoint(F#srtl_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)), F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)));
      invariant !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)));
      invariant !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)));
      invariant $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) <= $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node));
      invariant $non_null($phys_ptr_cast(local.a, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node));
      invariant $non_null($phys_ptr_cast(local.b, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node));
      invariant $non_null($phys_ptr_cast(L#last, ^s_node));
      invariant $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node) == $phys_ptr_cast(local.a, ^s_node) || $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node) == $phys_ptr_cast(local.b, ^s_node);
      invariant $non_null($phys_ptr_cast(local.a, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^s_node));
      invariant $non_null($phys_ptr_cast(local.a, ^s_node)) ==> $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^s_node));
      invariant $non_null($phys_ptr_cast(local.b, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.b, ^s_node));
      invariant $non_null($phys_ptr_cast(local.b, ^s_node)) ==> $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.b, ^s_node));
    {
      anon17:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$2^31.3, $s);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        // _Bool ite#1; 
        // ite#1 := ||(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(local.b)); 
        ite#1 := $non_null($phys_ptr_cast(local.a, ^s_node)) || $non_null($phys_ptr_cast(local.b, ^s_node));
        assume true;
        // if (ite#1) ...
        if (ite#1)
        {
          anon14:
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
            // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
            assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
            // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
            assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
            // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg(res, last), &&(sll_lseg(*((res->next)), last), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), last)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_reach(res, last), @_vcc_oset_union(sll_lseg_reach(*((res->next)), last), @_vcc_oset_singleton(res)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_keys(res, last), @_vcc_intset_union(sll_lseg_keys(*((res->next)), last), @_vcc_intset_singleton(*((res->key)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_len_next(res, last), unchecked+(sll_lseg_len_next(*((res->next)), last), 1))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), 1);
            // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(sll_lseg_max_key(res, last), @\int_max(*((res->key)), sll_lseg_max_key(*((res->next)), last)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
            // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(sll_lseg_min_key(res, last), @\int_min(*((res->key)), sll_lseg_min_key(*((res->next)), last)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
            // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(srtl_lseg(res, last), &&(&&(srtl_lseg(*((res->next)), last), unchecked!(@_vcc_oset_in(res, srtl_lseg_reach(*((res->next)), last)))), <=(*((res->key)), sll_lseg_min_key(*((res->next)), last))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(srtl_lseg_reach(res, last), @_vcc_oset_union(srtl_lseg_reach(*((res->next)), last), @_vcc_oset_singleton(res)))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
            // _Bool ite#2; 
            assume true;
            // if (@_vcc_ptr_eq_null(local.a)) ...
            if ($is_null($phys_ptr_cast(local.a, ^s_node)))
            {
              anon7:
                // assert @_vcc_possibly_unreachable; 
                assert {:PossiblyUnreachable true} true;
                // ite#2 := true; 
                ite#2 := true;
            }
            else
            {
              anon10:
                // assert @_vcc_possibly_unreachable; 
                assert {:PossiblyUnreachable true} true;
                // _Bool ite#3; 
                assume true;
                // if (@_vcc_ptr_neq_null(local.b)) ...
                if ($non_null($phys_ptr_cast(local.b, ^s_node)))
                {
                  anon8:
                    // assert @_vcc_possibly_unreachable; 
                    assert {:PossiblyUnreachable true} true;
                    // assert @reads_check_normal((local.a->key)); 
                    assert $thread_local($s, $phys_ptr_cast(local.a, ^s_node));
                    // assert @reads_check_normal((local.b->key)); 
                    assert $thread_local($s, $phys_ptr_cast(local.b, ^s_node));
                    // ite#3 := >(*((local.a->key)), *((local.b->key))); 
                    ite#3 := $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) > $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node));
                }
                else
                {
                  anon9:
                    // assert @_vcc_possibly_unreachable; 
                    assert {:PossiblyUnreachable true} true;
                    // ite#3 := false; 
                    ite#3 := false;
                }

              anon11:
                // ite#2 := ite#3; 
                ite#2 := ite#3;
            }

          anon15:
            assume true;
            // if (ite#2) ...
            if (ite#2)
            {
              anon12:
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg(res, last), &&(sll_lseg(*((res->next)), last), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), last)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_reach(res, last), @_vcc_oset_union(sll_lseg_reach(*((res->next)), last), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_keys(res, last), @_vcc_intset_union(sll_lseg_keys(*((res->next)), last), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_len_next(res, last), unchecked+(sll_lseg_len_next(*((res->next)), last), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), 1);
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(sll_lseg_max_key(res, last), @\int_max(*((res->key)), sll_lseg_max_key(*((res->next)), last)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(sll_lseg_min_key(res, last), @\int_min(*((res->key)), sll_lseg_min_key(*((res->next)), last)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(srtl_lseg(res, last), &&(&&(srtl_lseg(*((res->next)), last), unchecked!(@_vcc_oset_in(res, srtl_lseg_reach(*((res->next)), last)))), <=(*((res->key)), sll_lseg_min_key(*((res->next)), last))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(srtl_lseg_reach(res, last), @_vcc_oset_union(srtl_lseg_reach(*((res->next)), last), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // _math \state _dryad_S0; 
                // _dryad_S0 := @_vcc_current_state(@state); 
                SL#_dryad_S0 := $current_state($s);
                // _math \state stmtexpr0#9; 
                // stmtexpr0#9 := _dryad_S0; 
                stmtexpr0#9 := SL#_dryad_S0;
                // assert @prim_writes_check((last->next)); 
                assert $writable_prim($s, #wrTime$2^3.3, $dot($phys_ptr_cast(L#last, ^s_node), s_node.next));
                // *(last->next) := local.b; 
                call $write_int(s_node.next, $phys_ptr_cast(L#last, ^s_node), $ptr_to_int($phys_ptr_cast(local.b, ^s_node)));
                assume $full_stop_ext(#tok$2^57.7, $s);
                // _math \state _dryad_S1; 
                // _dryad_S1 := @_vcc_current_state(@state); 
                SL#_dryad_S1 := $current_state($s);
                // _math \state stmtexpr1#10; 
                // stmtexpr1#10 := _dryad_S1; 
                stmtexpr1#10 := SL#_dryad_S1;
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_keys(res)), old(_dryad_S1, sll_keys(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_list_len_next(res)), old(_dryad_S1, sll_list_len_next(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_list_len_next(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_list_len_next(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, rsrtl_reach(res)))), ==(old(_dryad_S0, rsrtl(res)), old(_dryad_S1, rsrtl(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#rsrtl(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#rsrtl(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, rsrtl_reach(res)))), ==(old(_dryad_S0, rsrtl_reach(res)), old(_dryad_S1, rsrtl_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#rsrtl_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll(res)), old(_dryad_S1, sll(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_reach(res)), old(_dryad_S1, sll_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_max_key(res)), old(_dryad_S1, sll_max_key(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_max_key(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_max_key(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_min_key(res)), old(_dryad_S1, sll_min_key(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_min_key(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_min_key(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_reach(res)))), ==(old(_dryad_S0, srtl(res)), old(_dryad_S1, srtl(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#srtl(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#srtl(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_reach(res)))), ==(old(_dryad_S0, srtl_reach(res)), old(_dryad_S1, srtl_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#srtl_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.b)))), ==(old(_dryad_S0, sll_keys(local.b)), old(_dryad_S1, sll_keys(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.b)))), ==(old(_dryad_S0, sll_list_len_next(local.b)), old(_dryad_S1, sll_list_len_next(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_list_len_next(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_list_len_next(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, rsrtl_reach(local.b)))), ==(old(_dryad_S0, rsrtl(local.b)), old(_dryad_S1, rsrtl(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#rsrtl(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#rsrtl(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, rsrtl_reach(local.b)))), ==(old(_dryad_S0, rsrtl_reach(local.b)), old(_dryad_S1, rsrtl_reach(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#rsrtl_reach(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.b)))), ==(old(_dryad_S0, sll(local.b)), old(_dryad_S1, sll(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.b)))), ==(old(_dryad_S0, sll_reach(local.b)), old(_dryad_S1, sll_reach(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.b)))), ==(old(_dryad_S0, sll_max_key(local.b)), old(_dryad_S1, sll_max_key(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_max_key(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_max_key(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.b)))), ==(old(_dryad_S0, sll_min_key(local.b)), old(_dryad_S1, sll_min_key(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_min_key(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_min_key(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_reach(local.b)))), ==(old(_dryad_S0, srtl(local.b)), old(_dryad_S1, srtl(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#srtl(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#srtl(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_reach(local.b)))), ==(old(_dryad_S0, srtl_reach(local.b)), old(_dryad_S1, srtl_reach(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node))) ==> F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.b, ^s_node)) == F#srtl_reach(SL#_dryad_S1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.a)))), ==(old(_dryad_S0, sll_keys(local.a)), old(_dryad_S1, sll_keys(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.a)))), ==(old(_dryad_S0, sll_list_len_next(local.a)), old(_dryad_S1, sll_list_len_next(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_list_len_next(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_list_len_next(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, rsrtl_reach(local.a)))), ==(old(_dryad_S0, rsrtl(local.a)), old(_dryad_S1, rsrtl(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#rsrtl(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#rsrtl(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, rsrtl_reach(local.a)))), ==(old(_dryad_S0, rsrtl_reach(local.a)), old(_dryad_S1, rsrtl_reach(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#rsrtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#rsrtl_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.a)))), ==(old(_dryad_S0, sll(local.a)), old(_dryad_S1, sll(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.a)))), ==(old(_dryad_S0, sll_reach(local.a)), old(_dryad_S1, sll_reach(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.a)))), ==(old(_dryad_S0, sll_max_key(local.a)), old(_dryad_S1, sll_max_key(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_max_key(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_max_key(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_reach(local.a)))), ==(old(_dryad_S0, sll_min_key(local.a)), old(_dryad_S1, sll_min_key(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_min_key(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_min_key(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_reach(local.a)))), ==(old(_dryad_S0, srtl(local.a)), old(_dryad_S1, srtl(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#srtl(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#srtl(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_reach(local.a)))), ==(old(_dryad_S0, srtl_reach(local.a)), old(_dryad_S1, srtl_reach(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node))) ==> F#srtl_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^s_node)) == F#srtl_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0, sll_lseg(res, last)), old(_dryad_S1, sll_lseg(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0, sll_lseg_reach(res, last)), old(_dryad_S1, sll_lseg_reach(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0, sll_lseg_keys(res, last)), old(_dryad_S1, sll_lseg_keys(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0, sll_lseg_len_next(res, last)), old(_dryad_S1, sll_lseg_len_next(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_len_next(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_len_next(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0, sll_lseg_max_key(res, last)), old(_dryad_S1, sll_lseg_max_key(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_max_key(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_max_key(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0, sll_lseg_min_key(res, last)), old(_dryad_S1, sll_lseg_min_key(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_min_key(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_min_key(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_lseg_reach(res, last)))), ==(old(_dryad_S0, srtl_lseg(res, last)), old(_dryad_S1, srtl_lseg(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#srtl_lseg(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#srtl_lseg(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0, srtl_lseg_reach(res, last)))), ==(old(_dryad_S0, srtl_lseg_reach(res, last)), old(_dryad_S1, srtl_lseg_reach(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#srtl_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#srtl_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, res)), ==(*((res->key)), old(_dryad_S0, *((res->key))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(L#res, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, res)), @_vcc_ptr_eq_pure(*((res->next)), old(_dryad_S0, *((res->next))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(L#res, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node);
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.b)), ==(*((local.b->key)), old(_dryad_S0, *((local.b->key))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.b, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.b)), @_vcc_ptr_eq_pure(*((local.b->next)), old(_dryad_S0, *((local.b->next))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.b, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node);
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.a)), ==(*((local.a->key)), old(_dryad_S0, *((local.a->key))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.a, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.a)), @_vcc_ptr_eq_pure(*((local.a->next)), old(_dryad_S0, *((local.a->next))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.a, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // last := local.b; 
                L#last := $phys_ptr_cast(local.b, ^s_node);
                // assert sll_lseg(res, res); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume sll_lseg(res, res); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert srtl_lseg(res, res); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume srtl_lseg(res, res); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert sll_lseg(last, last); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume sll_lseg(last, last); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert srtl_lseg(last, last); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume srtl_lseg(last, last); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert sll_lseg(local.b, local.b); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume sll_lseg(local.b, local.b); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert srtl_lseg(local.b, local.b); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume srtl_lseg(local.b, local.b); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert sll_lseg(local.a, local.a); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume sll_lseg(local.a, local.a); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assert srtl_lseg(local.a, local.a); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume srtl_lseg(local.a, local.a); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // struct s_node* b1; 
                // b1 := local.b; 
                SL#b1 := $phys_ptr_cast(local.b, ^s_node);
                // struct s_node* stmtexpr2#11; 
                // stmtexpr2#11 := b1; 
                stmtexpr2#11 := $phys_ptr_cast(SL#b1, ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg(local.b, *((local.b->next))), &&(sll_lseg(*((local.b->next)), *((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_lseg_reach(*((local.b->next)), *((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg_reach(local.b, *((local.b->next))), @_vcc_oset_union(sll_lseg_reach(*((local.b->next)), *((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg_keys(local.b, *((local.b->next))), @_vcc_intset_union(sll_lseg_keys(*((local.b->next)), *((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(sll_lseg_len_next(local.b, *((local.b->next))), unchecked+(sll_lseg_len_next(*((local.b->next)), *((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), @_vcc_ptr_neq_pure(*((local.b->next)), *((local.b->next)))), ==(sll_lseg_max_key(local.b, *((local.b->next))), @\int_max(*((local.b->key)), sll_lseg_max_key(*((local.b->next)), *((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), @_vcc_ptr_neq_pure(*((local.b->next)), *((local.b->next)))), ==(sll_lseg_min_key(local.b, *((local.b->next))), @\int_min(*((local.b->key)), sll_lseg_min_key(*((local.b->next)), *((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), @_vcc_ptr_neq_pure(*((local.b->next)), *((local.b->next)))), ==(srtl_lseg(local.b, *((local.b->next))), &&(&&(srtl_lseg(*((local.b->next)), *((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_lseg_reach(*((local.b->next)), *((local.b->next)))))), <=(*((local.b->key)), sll_lseg_min_key(*((local.b->next)), *((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_pure(local.b, *((local.b->next)))), ==(srtl_lseg_reach(local.b, *((local.b->next))), @_vcc_oset_union(srtl_lseg_reach(*((local.b->next)), *((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $phys_ptr_cast(local.b, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(local.b, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assert @reads_check_normal((local.b->next)); 
                assert $thread_local($s, $phys_ptr_cast(local.b, ^s_node));
                // local.b := *((local.b->next)); 
                local.b := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), &&(@_vcc_mutable(@state, local.b), @writes_check(local.b))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.b, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.b, ^s_node));
            }
            else
            {
              anon13:
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg(res, last), &&(sll_lseg(*((res->next)), last), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), last)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_reach(res, last), @_vcc_oset_union(sll_lseg_reach(*((res->next)), last), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_keys(res, last), @_vcc_intset_union(sll_lseg_keys(*((res->next)), last), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(sll_lseg_len_next(res, last), unchecked+(sll_lseg_len_next(*((res->next)), last), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), 1);
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(sll_lseg_max_key(res, last), @\int_max(*((res->key)), sll_lseg_max_key(*((res->next)), last)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(sll_lseg_min_key(res, last), @\int_min(*((res->key)), sll_lseg_min_key(*((res->next)), last)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), @_vcc_ptr_neq_pure(*((res->next)), last)), ==(srtl_lseg(res, last), &&(&&(srtl_lseg(*((res->next)), last), unchecked!(@_vcc_oset_in(res, srtl_lseg_reach(*((res->next)), last)))), <=(*((res->key)), sll_lseg_min_key(*((res->next)), last))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, last)), ==(srtl_lseg_reach(res, last), @_vcc_oset_union(srtl_lseg_reach(*((res->next)), last), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#last, ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#last, ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // _math \state _dryad_S0#0; 
                // _dryad_S0#0 := @_vcc_current_state(@state); 
                _dryad_S0#0 := $current_state($s);
                // _math \state stmtexpr0#12; 
                // stmtexpr0#12 := _dryad_S0#0; 
                stmtexpr0#12 := _dryad_S0#0;
                // assert @prim_writes_check((last->next)); 
                assert $writable_prim($s, #wrTime$2^3.3, $dot($phys_ptr_cast(L#last, ^s_node), s_node.next));
                // *(last->next) := local.a; 
                call $write_int(s_node.next, $phys_ptr_cast(L#last, ^s_node), $ptr_to_int($phys_ptr_cast(local.a, ^s_node)));
                assume $full_stop_ext(#tok$2^62.7, $s);
                // _math \state _dryad_S1#1; 
                // _dryad_S1#1 := @_vcc_current_state(@state); 
                _dryad_S1#1 := $current_state($s);
                // _math \state stmtexpr1#13; 
                // stmtexpr1#13 := _dryad_S1#1; 
                stmtexpr1#13 := _dryad_S1#1;
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(res)))), ==(old(_dryad_S0#0, sll_keys(res)), old(_dryad_S1#1, sll_keys(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_keys(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_keys(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(res)))), ==(old(_dryad_S0#0, sll_list_len_next(res)), old(_dryad_S1#1, sll_list_len_next(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_list_len_next(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_list_len_next(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, rsrtl_reach(res)))), ==(old(_dryad_S0#0, rsrtl(res)), old(_dryad_S1#1, rsrtl(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#rsrtl(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#rsrtl(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, rsrtl_reach(res)))), ==(old(_dryad_S0#0, rsrtl_reach(res)), old(_dryad_S1#1, rsrtl_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#rsrtl_reach(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(res)))), ==(old(_dryad_S0#0, sll(res)), old(_dryad_S1#1, sll(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#sll(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(res)))), ==(old(_dryad_S0#0, sll_reach(res)), old(_dryad_S1#1, sll_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_reach(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(res)))), ==(old(_dryad_S0#0, sll_max_key(res)), old(_dryad_S1#1, sll_max_key(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_max_key(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_max_key(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(res)))), ==(old(_dryad_S0#0, sll_min_key(res)), old(_dryad_S1#1, sll_min_key(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_min_key(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_min_key(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_reach(res)))), ==(old(_dryad_S0#0, srtl(res)), old(_dryad_S1#1, srtl(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#srtl(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#srtl(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_reach(res)))), ==(old(_dryad_S0#0, srtl_reach(res)), old(_dryad_S1#1, srtl_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node))) ==> F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node)) == F#srtl_reach(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.b)))), ==(old(_dryad_S0#0, sll_keys(local.b)), old(_dryad_S1#1, sll_keys(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_keys(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_keys(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.b)))), ==(old(_dryad_S0#0, sll_list_len_next(local.b)), old(_dryad_S1#1, sll_list_len_next(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_list_len_next(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_list_len_next(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, rsrtl_reach(local.b)))), ==(old(_dryad_S0#0, rsrtl(local.b)), old(_dryad_S1#1, rsrtl(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#rsrtl(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#rsrtl(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, rsrtl_reach(local.b)))), ==(old(_dryad_S0#0, rsrtl_reach(local.b)), old(_dryad_S1#1, rsrtl_reach(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#rsrtl_reach(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.b)))), ==(old(_dryad_S0#0, sll(local.b)), old(_dryad_S1#1, sll(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#sll(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.b)))), ==(old(_dryad_S0#0, sll_reach(local.b)), old(_dryad_S1#1, sll_reach(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_reach(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.b)))), ==(old(_dryad_S0#0, sll_max_key(local.b)), old(_dryad_S1#1, sll_max_key(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_max_key(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_max_key(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.b)))), ==(old(_dryad_S0#0, sll_min_key(local.b)), old(_dryad_S1#1, sll_min_key(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#sll_min_key(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#sll_min_key(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_reach(local.b)))), ==(old(_dryad_S0#0, srtl(local.b)), old(_dryad_S1#1, srtl(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#srtl(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#srtl(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_reach(local.b)))), ==(old(_dryad_S0#0, srtl_reach(local.b)), old(_dryad_S1#1, srtl_reach(local.b)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node))) ==> F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(local.b, ^s_node)) == F#srtl_reach(_dryad_S1#1, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.a)))), ==(old(_dryad_S0#0, sll_keys(local.a)), old(_dryad_S1#1, sll_keys(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_keys(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_keys(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.a)))), ==(old(_dryad_S0#0, sll_list_len_next(local.a)), old(_dryad_S1#1, sll_list_len_next(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_list_len_next(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_list_len_next(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, rsrtl_reach(local.a)))), ==(old(_dryad_S0#0, rsrtl(local.a)), old(_dryad_S1#1, rsrtl(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#rsrtl(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#rsrtl(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, rsrtl_reach(local.a)))), ==(old(_dryad_S0#0, rsrtl_reach(local.a)), old(_dryad_S1#1, rsrtl_reach(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#rsrtl_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#rsrtl_reach(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.a)))), ==(old(_dryad_S0#0, sll(local.a)), old(_dryad_S1#1, sll(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#sll(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.a)))), ==(old(_dryad_S0#0, sll_reach(local.a)), old(_dryad_S1#1, sll_reach(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_reach(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.a)))), ==(old(_dryad_S0#0, sll_max_key(local.a)), old(_dryad_S1#1, sll_max_key(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_max_key(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_max_key(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_reach(local.a)))), ==(old(_dryad_S0#0, sll_min_key(local.a)), old(_dryad_S1#1, sll_min_key(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#sll_min_key(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#sll_min_key(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_reach(local.a)))), ==(old(_dryad_S0#0, srtl(local.a)), old(_dryad_S1#1, srtl(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#srtl(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#srtl(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_reach(local.a)))), ==(old(_dryad_S0#0, srtl_reach(local.a)), old(_dryad_S1#1, srtl_reach(local.a)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node))) ==> F#srtl_reach(_dryad_S0#0, $phys_ptr_cast(local.a, ^s_node)) == F#srtl_reach(_dryad_S1#1, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0#0, sll_lseg(res, last)), old(_dryad_S1#1, sll_lseg(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0#0, sll_lseg_reach(res, last)), old(_dryad_S1#1, sll_lseg_reach(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_reach(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0#0, sll_lseg_keys(res, last)), old(_dryad_S1#1, sll_lseg_keys(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_keys(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0#0, sll_lseg_len_next(res, last)), old(_dryad_S1#1, sll_lseg_len_next(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_len_next(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_len_next(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0#0, sll_lseg_max_key(res, last)), old(_dryad_S1#1, sll_lseg_max_key(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_max_key(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_max_key(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, sll_lseg_reach(res, last)))), ==(old(_dryad_S0#0, sll_lseg_min_key(res, last)), old(_dryad_S1#1, sll_lseg_min_key(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#sll_lseg_min_key(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#sll_lseg_min_key(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_lseg_reach(res, last)))), ==(old(_dryad_S0#0, srtl_lseg(res, last)), old(_dryad_S1#1, srtl_lseg(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#srtl_lseg(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#srtl_lseg(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(last, old(_dryad_S0#0, srtl_lseg_reach(res, last)))), ==(old(_dryad_S0#0, srtl_lseg_reach(res, last)), old(_dryad_S1#1, srtl_lseg_reach(res, last)))); 
                assume !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node))) ==> F#srtl_lseg_reach(_dryad_S0#0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node)) == F#srtl_lseg_reach(_dryad_S1#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, res)), ==(*((res->key)), old(_dryad_S0#0, *((res->key))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(L#res, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) == $rd_inv(_dryad_S0#0, s_node.key, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, res)), @_vcc_ptr_eq_pure(*((res->next)), old(_dryad_S0#0, *((res->next))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(L#res, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#0, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node);
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.b)), ==(*((local.b->key)), old(_dryad_S0#0, *((local.b->key))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.b, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) == $rd_inv(_dryad_S0#0, s_node.key, $phys_ptr_cast(local.b, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.b)), @_vcc_ptr_eq_pure(*((local.b->next)), old(_dryad_S0#0, *((local.b->next))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.b, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#0, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node);
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.a)), ==(*((local.a->key)), old(_dryad_S0#0, *((local.a->key))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.a, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) == $rd_inv(_dryad_S0#0, s_node.key, $phys_ptr_cast(local.a, ^s_node));
                // assume ==>(!(@_vcc_ptr_eq_pure(last, local.a)), @_vcc_ptr_eq_pure(*((local.a->next)), old(_dryad_S0#0, *((local.a->next))))); 
                assume !($phys_ptr_cast(L#last, ^s_node) == $phys_ptr_cast(local.a, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#0, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
                assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
                assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // last := local.a; 
                L#last := $phys_ptr_cast(local.a, ^s_node);
                // assert sll_lseg(res, res); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume sll_lseg(res, res); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert srtl_lseg(res, res); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume srtl_lseg(res, res); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert sll_lseg(last, last); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume sll_lseg(last, last); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert srtl_lseg(last, last); 
                assert F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assume srtl_lseg(last, last); 
                assume F#srtl_lseg($s, $phys_ptr_cast(L#last, ^s_node), $phys_ptr_cast(L#last, ^s_node));
                // assert sll_lseg(local.b, local.b); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume sll_lseg(local.b, local.b); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert srtl_lseg(local.b, local.b); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assume srtl_lseg(local.b, local.b); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.b, ^s_node), $phys_ptr_cast(local.b, ^s_node));
                // assert sll_lseg(local.a, local.a); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume sll_lseg(local.a, local.a); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assert srtl_lseg(local.a, local.a); 
                assert F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // assume srtl_lseg(local.a, local.a); 
                assume F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $phys_ptr_cast(local.a, ^s_node));
                // struct s_node* a1; 
                // a1 := local.a; 
                SL#a1 := $phys_ptr_cast(local.a, ^s_node);
                // struct s_node* stmtexpr2#14; 
                // stmtexpr2#14 := a1; 
                stmtexpr2#14 := $phys_ptr_cast(SL#a1, ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg(local.a, *((local.a->next))), &&(sll_lseg(*((local.a->next)), *((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_lseg_reach(*((local.a->next)), *((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg_reach(local.a, *((local.a->next))), @_vcc_oset_union(sll_lseg_reach(*((local.a->next)), *((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $oset_union(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg_keys(local.a, *((local.a->next))), @_vcc_intset_union(sll_lseg_keys(*((local.a->next)), *((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(sll_lseg_len_next(local.a, *((local.a->next))), unchecked+(sll_lseg_len_next(*((local.a->next)), *((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_len_next($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $unchk_add(^^nat, F#sll_lseg_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), @_vcc_ptr_neq_pure(*((local.a->next)), *((local.a->next)))), ==(sll_lseg_max_key(local.a, *((local.a->next))), @\int_max(*((local.a->key)), sll_lseg_max_key(*((local.a->next)), *((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_max_key($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_lseg_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), @_vcc_ptr_neq_pure(*((local.a->next)), *((local.a->next)))), ==(sll_lseg_min_key(local.a, *((local.a->next))), @\int_min(*((local.a->key)), sll_lseg_min_key(*((local.a->next)), *((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#sll_lseg_min_key($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), @_vcc_ptr_neq_pure(*((local.a->next)), *((local.a->next)))), ==(srtl_lseg(local.a, *((local.a->next))), &&(&&(srtl_lseg(*((local.a->next)), *((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_lseg_reach(*((local.a->next)), *((local.a->next)))))), <=(*((local.a->key)), sll_lseg_min_key(*((local.a->next)), *((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) && $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#srtl_lseg($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == (F#srtl_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_lseg_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_pure(local.a, *((local.a->next)))), ==(srtl_lseg_reach(local.a, *((local.a->next))), @_vcc_oset_union(srtl_lseg_reach(*((local.a->next)), *((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $phys_ptr_cast(local.a, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node) ==> F#srtl_lseg_reach($s, $phys_ptr_cast(local.a, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) == $oset_union(F#srtl_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assert @reads_check_normal((local.a->next)); 
                assert $thread_local($s, $phys_ptr_cast(local.a, ^s_node));
                // local.a := *((local.a->next)); 
                local.a := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
                // assume ==>(@_vcc_ptr_neq_null(local.a), &&(@_vcc_mutable(@state, local.a), @writes_check(local.a))); 
                assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^s_node));
            }
        }
        else
        {
          anon16:
            // assert @_vcc_possibly_unreachable; 
            assert {:PossiblyUnreachable true} true;
            // goto #break_4; 
            goto #break_4;
        }

      #continue_4:
        assume true;
    }

  anon20:
    assume $full_stop_ext(#tok$2^31.3, $s);

  #break_4:
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_list_len_next(res), unchecked+(sll_list_len_next(*((res->next))), 1))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#res, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(rsrtl(res), &&(&&(rsrtl(*((res->next))), unchecked!(@_vcc_oset_in(res, rsrtl_reach(*((res->next)))))), >=(*((res->key)), sll_max_key(*((res->next))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(rsrtl_reach(res), @_vcc_oset_union(rsrtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union(sll_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_max_key(res), @\int_max(*((res->key)), sll_max_key(*((res->next)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(sll_min_key(res), @\int_min(*((res->key)), sll_min_key(*((res->next)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#res, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_null(*((res->next)))), ==(srtl(res), &&(&&(srtl(*((res->next))), unchecked!(@_vcc_oset_in(res, srtl_reach(*((res->next)))))), <=(*((res->key)), sll_min_key(*((res->next))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#res, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(srtl_reach(res), @_vcc_oset_union(srtl_reach(*((res->next))), @_vcc_oset_singleton(res)))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#res, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_keys(last), @_vcc_intset_union(sll_keys(*((last->next))), @_vcc_intset_singleton(*((last->key)))))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#last, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_list_len_next(last), unchecked+(sll_list_len_next(*((last->next))), 1))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(L#last, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(rsrtl(last), &&(&&(rsrtl(*((last->next))), unchecked!(@_vcc_oset_in(last, rsrtl_reach(*((last->next)))))), >=(*((last->key)), sll_max_key(*((last->next))))))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(last), ==(rsrtl_reach(last), @_vcc_oset_union(rsrtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(last), ==(sll(last), &&(sll(*((last->next))), unchecked!(@_vcc_oset_in(last, sll_reach(*((last->next)))))))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#last, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(last), ==(sll_reach(last), @_vcc_oset_union(sll_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_max_key(last), @\int_max(*((last->key)), sll_max_key(*((last->next)))))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(sll_min_key(last), @\int_min(*((last->key)), sll_min_key(*((last->next)))))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(L#last, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(last), @_vcc_ptr_neq_null(*((last->next)))), ==(srtl(last), &&(&&(srtl(*((last->next))), unchecked!(@_vcc_oset_in(last, srtl_reach(*((last->next)))))), <=(*((last->key)), sll_min_key(*((last->next))))))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(L#last, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#last, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(L#last, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(last), ==(srtl_reach(last), @_vcc_oset_union(srtl_reach(*((last->next))), @_vcc_oset_singleton(last)))); 
    assume $non_null($phys_ptr_cast(L#last, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(L#last, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#last, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(L#last, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_keys(local.b), @_vcc_intset_union(sll_keys(*((local.b->next))), @_vcc_intset_singleton(*((local.b->key)))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.b, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_list_len_next(local.b), unchecked+(sll_list_len_next(*((local.b->next))), 1))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.b, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(rsrtl(local.b), &&(&&(rsrtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, rsrtl_reach(*((local.b->next)))))), >=(*((local.b->key)), sll_max_key(*((local.b->next))))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(rsrtl_reach(local.b), @_vcc_oset_union(rsrtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll(local.b), &&(sll(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, sll_reach(*((local.b->next)))))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.b, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(sll_reach(local.b), @_vcc_oset_union(sll_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_max_key(local.b), @\int_max(*((local.b->key)), sll_max_key(*((local.b->next)))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(sll_min_key(local.b), @\int_min(*((local.b->key)), sll_min_key(*((local.b->next)))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.b, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.b), @_vcc_ptr_neq_null(*((local.b->next)))), ==(srtl(local.b), &&(&&(srtl(*((local.b->next))), unchecked!(@_vcc_oset_in(local.b, srtl_reach(*((local.b->next)))))), <=(*((local.b->key)), sll_min_key(*((local.b->next))))))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.b, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.b, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.b, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.b), ==(srtl_reach(local.b), @_vcc_oset_union(srtl_reach(*((local.b->next))), @_vcc_oset_singleton(local.b)))); 
    assume $non_null($phys_ptr_cast(local.b, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.b, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.b, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.b, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_keys(local.a), @_vcc_intset_union(sll_keys(*((local.a->next))), @_vcc_intset_singleton(*((local.a->key)))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.a, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_list_len_next(local.a), unchecked+(sll_list_len_next(*((local.a->next))), 1))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_list_len_next($s, $phys_ptr_cast(local.a, ^s_node)) == $unchk_add(^^nat, F#sll_list_len_next($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), 1);
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(rsrtl(local.a), &&(&&(rsrtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, rsrtl_reach(*((local.a->next)))))), >=(*((local.a->key)), sll_max_key(*((local.a->next))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#rsrtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#rsrtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) >= F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(rsrtl_reach(local.a), @_vcc_oset_union(rsrtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#rsrtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#rsrtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll(local.a), &&(sll(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, sll_reach(*((local.a->next)))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.a, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(sll_reach(local.a), @_vcc_oset_union(sll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_max_key(local.a), @\int_max(*((local.a->key)), sll_max_key(*((local.a->next)))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_max_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_max($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_max_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(sll_min_key(local.a), @\int_min(*((local.a->key)), sll_min_key(*((local.a->next)))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#sll_min_key($s, $phys_ptr_cast(local.a, ^s_node)) == $int_min($rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)), F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(&&(@_vcc_ptr_neq_null(local.a), @_vcc_ptr_neq_null(*((local.a->next)))), ==(srtl(local.a), &&(&&(srtl(*((local.a->next))), unchecked!(@_vcc_oset_in(local.a, srtl_reach(*((local.a->next)))))), <=(*((local.a->key)), sll_min_key(*((local.a->next))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) && $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) ==> F#srtl($s, $phys_ptr_cast(local.a, ^s_node)) == (F#srtl($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.a, ^s_node), F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node))) && $rd_inv($s, s_node.key, $phys_ptr_cast(local.a, ^s_node)) <= F#sll_min_key($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(srtl_reach(local.a), @_vcc_oset_union(srtl_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^s_node)) ==> F#srtl_reach($s, $phys_ptr_cast(local.a, ^s_node)) == $oset_union(F#srtl_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.a, ^s_node), ^s_node)), $oset_singleton($phys_ptr_cast(local.a, ^s_node)));
    // return res; 
    $result := $phys_ptr_cast(L#res, ^s_node);
    assume true;
    assert $position_marker();
    goto #exit;

  anon21:
    // skip

  #exit:
}



axiom (forall Q#__vcc_state$1^687.9#tc2#1662: $state, Q#x$1^687.9#dt1#1619: $ptr :: {:weight 10} { F#srtl(Q#__vcc_state$1^687.9#tc2#1662, $phys_ptr_cast(Q#x$1^687.9#dt1#1619, ^s_node)) } { F#sll(Q#__vcc_state$1^687.9#tc2#1662, $phys_ptr_cast(Q#x$1^687.9#dt1#1619, ^s_node)) } $good_state(Q#__vcc_state$1^687.9#tc2#1662) && true ==> F#srtl(Q#__vcc_state$1^687.9#tc2#1662, $phys_ptr_cast(Q#x$1^687.9#dt1#1619, ^s_node)) ==> F#sll(Q#__vcc_state$1^687.9#tc2#1662, $phys_ptr_cast(Q#x$1^687.9#dt1#1619, ^s_node)));

axiom (forall Q#__vcc_state$1^688.9#tc2#1663: $state, Q#x$1^688.9#dt1#1620: $ptr :: {:weight 10} { F#rsrtl(Q#__vcc_state$1^688.9#tc2#1663, $phys_ptr_cast(Q#x$1^688.9#dt1#1620, ^s_node)) } { F#sll(Q#__vcc_state$1^688.9#tc2#1663, $phys_ptr_cast(Q#x$1^688.9#dt1#1620, ^s_node)) } $good_state(Q#__vcc_state$1^688.9#tc2#1663) && true ==> F#rsrtl(Q#__vcc_state$1^688.9#tc2#1663, $phys_ptr_cast(Q#x$1^688.9#dt1#1620, ^s_node)) ==> F#sll(Q#__vcc_state$1^688.9#tc2#1663, $phys_ptr_cast(Q#x$1^688.9#dt1#1620, ^s_node)));

axiom (forall Q#__vcc_state$1^689.9#tc2#1664: $state, Q#x$1^689.9#dt1#1621: $ptr :: {:weight 10} { F#sll_reach(Q#__vcc_state$1^689.9#tc2#1664, $phys_ptr_cast(Q#x$1^689.9#dt1#1621, ^s_node)) } { F#srtl_reach(Q#__vcc_state$1^689.9#tc2#1664, $phys_ptr_cast(Q#x$1^689.9#dt1#1621, ^s_node)) } $good_state(Q#__vcc_state$1^689.9#tc2#1664) && true ==> F#sll_reach(Q#__vcc_state$1^689.9#tc2#1664, $phys_ptr_cast(Q#x$1^689.9#dt1#1621, ^s_node)) == F#srtl_reach(Q#__vcc_state$1^689.9#tc2#1664, $phys_ptr_cast(Q#x$1^689.9#dt1#1621, ^s_node)));

axiom (forall Q#__vcc_state$1^690.9#tc2#1665: $state, Q#x$1^690.9#dt1#1622: $ptr :: {:weight 10} { F#srtl_reach(Q#__vcc_state$1^690.9#tc2#1665, $phys_ptr_cast(Q#x$1^690.9#dt1#1622, ^s_node)) } { F#rsrtl_reach(Q#__vcc_state$1^690.9#tc2#1665, $phys_ptr_cast(Q#x$1^690.9#dt1#1622, ^s_node)) } $good_state(Q#__vcc_state$1^690.9#tc2#1665) && true ==> F#srtl_reach(Q#__vcc_state$1^690.9#tc2#1665, $phys_ptr_cast(Q#x$1^690.9#dt1#1622, ^s_node)) == F#rsrtl_reach(Q#__vcc_state$1^690.9#tc2#1665, $phys_ptr_cast(Q#x$1^690.9#dt1#1622, ^s_node)));

axiom (forall Q#__vcc_state$1^691.9#tc2#1666: $state, Q#x$1^691.9#dt1#1623: $ptr, Q#y$1^691.9#dt1#1624: $ptr :: {:weight 10} { F#sll_lseg_reach(Q#__vcc_state$1^691.9#tc2#1666, $phys_ptr_cast(Q#x$1^691.9#dt1#1623, ^s_node), $phys_ptr_cast(Q#y$1^691.9#dt1#1624, ^s_node)) } { F#srtl_lseg_reach(Q#__vcc_state$1^691.9#tc2#1666, $phys_ptr_cast(Q#x$1^691.9#dt1#1623, ^s_node), $phys_ptr_cast(Q#y$1^691.9#dt1#1624, ^s_node)) } $good_state(Q#__vcc_state$1^691.9#tc2#1666) && true ==> F#sll_lseg_reach(Q#__vcc_state$1^691.9#tc2#1666, $phys_ptr_cast(Q#x$1^691.9#dt1#1623, ^s_node), $phys_ptr_cast(Q#y$1^691.9#dt1#1624, ^s_node)) == F#srtl_lseg_reach(Q#__vcc_state$1^691.9#tc2#1666, $phys_ptr_cast(Q#x$1^691.9#dt1#1623, ^s_node), $phys_ptr_cast(Q#y$1^691.9#dt1#1624, ^s_node)));

const unique l#public: $label;

axiom $type_code_is(2, ^$#state_t);

const unique #tok$2^62.7: $token;

const unique #tok$2^57.7: $token;

const unique #tok$2^31.3: $token;

const unique #tok$3^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(3, #file^?3Cno?20file?3E);

const unique #tok$2^3.3: $token;

const unique #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Csls?5Csls_merge.c: $token;

axiom $file_name_is(2, #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Csls?5Csls_merge.c);

const unique #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Csls?5Cdryad_sls.h: $token;

axiom $file_name_is(1, #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Csls?5Cdryad_sls.h);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^s_node);
