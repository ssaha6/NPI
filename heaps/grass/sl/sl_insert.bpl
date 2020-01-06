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

const unique ^$#sl_insert.c..36263#3: $ctype;

axiom $def_fnptr_type(^$#sl_insert.c..36263#3);

type $#sl_insert.c..36263#3;

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

function F#sll(#s: $state, SP#hd: $ptr) : bool;

const unique cf#sll: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#sll(#s, SP#hd) } 1 < $decreases_level ==> $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> F#sll(#s, SP#hd));

axiom $function_arg_type(cf#sll, 0, ^^bool);

axiom $function_arg_type(cf#sll, 1, $ptr_to(^s_node));

procedure sll(SP#hd: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) ==> $result;
  free ensures $result == F#sll($s, SP#hd);
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



function F#sll_lseg(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : bool;

const unique cf#sll_lseg: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg(#s, SP#hd, SP#tl)) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg(#s, SP#hd, SP#tl)) && ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg(#s, SP#hd, SP#tl) == F#sll(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && F#sll(#s, $phys_ptr_cast(SP#tl, ^s_node)) && $oset_disjoint(F#sll_reach(#s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> F#sll(#s, $phys_ptr_cast(SP#hd, ^s_node)) && F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_reach(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_keys(#s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && F#sll(#s, $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) && $oset_disjoint(F#sll_reach(#s, $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach(#s, $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> $oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node))) && F#sll_lseg(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union($intset_singleton($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))), F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union_one1($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)))));

axiom $function_arg_type(cf#sll_lseg, 0, ^^bool);

axiom $function_arg_type(cf#sll_lseg, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg, 2, $ptr_to(^s_node));

procedure sll_lseg(SP#hd: $ptr, SP#tl: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && F#sll($s, $phys_ptr_cast(SP#tl, ^s_node)) && $oset_disjoint(F#sll_reach($s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> F#sll($s, $phys_ptr_cast(SP#hd, ^s_node)) && F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_reach($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys($s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_keys($s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)));
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)) && $oset_disjoint(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> $oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node))) && F#sll_lseg($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union($intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))), F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union_one1($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)));
  free ensures $result == F#sll_lseg($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_reach(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : $oset;

const unique cf#sll_lseg_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_reach(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_reach(#s, SP#hd, SP#tl) == $oset_empty()) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_reach(#s, SP#hd, SP#tl) == $oset_empty()) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), F#sll_lseg_reach(#s, SP#hd, SP#tl))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_reach(#s, SP#hd, SP#tl) == F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node))));

axiom $function_arg_type(cf#sll_lseg_reach, 0, ^$#oset);

axiom $function_arg_type(cf#sll_lseg_reach, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_reach, 2, $ptr_to(^s_node));

procedure sll_lseg_reach(SP#hd: $ptr, SP#tl: $ptr) returns ($result: $oset);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $oset_empty();
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $oset_empty();
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^s_node), $result);
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node));
  free ensures $result == F#sll_lseg_reach($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#sll_lseg_keys(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : $intset;

const unique cf#sll_lseg_keys: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg_keys(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_keys(#s, SP#hd, SP#tl) == $intset_empty()) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg_keys(#s, SP#hd, SP#tl) == $intset_empty()) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $intset_in($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node)), F#sll_lseg_keys(#s, SP#hd, SP#tl))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg_keys(#s, SP#hd, SP#tl) == F#sll_keys(#s, $phys_ptr_cast(SP#hd, ^s_node))));

axiom $function_arg_type(cf#sll_lseg_keys, 0, ^$#intset);

axiom $function_arg_type(cf#sll_lseg_keys, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg_keys, 2, $ptr_to(^s_node));

procedure sll_lseg_keys(SP#hd: $ptr, SP#tl: $ptr) returns ($result: $intset);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $intset_empty();
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result == $intset_empty();
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $intset_in($rd_inv($s, s_node.key, $phys_ptr_cast(SP#hd, ^s_node)), $result);
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll_keys($s, $phys_ptr_cast(SP#hd, ^s_node));
  free ensures $result == F#sll_lseg_keys($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#havoc() : int;

const unique cf#havoc: $pure_function;

axiom $in_range_i4(F#havoc());

axiom $function_arg_type(cf#havoc, 0, ^^i4);

procedure \havoc() returns ($result: int);
  free ensures $in_range_i4($result);
  free ensures $result == F#havoc();
  free ensures $call_transition(old($s), $s);



procedure sl_insert(P#lst: $ptr, P#elt: $ptr) returns ($result: $ptr);
  requires F#sll($s, $phys_ptr_cast(P#lst, ^s_node));
  requires $non_null($phys_ptr_cast(P#elt, ^s_node));
  requires $is_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node));
  requires !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)));
  modifies $s, $cev_pc;
  ensures F#sll($s, $phys_ptr_cast($result, ^s_node));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation sl_insert(P#lst: $ptr, P#elt: $ptr) returns ($result: $ptr)
{
  var stmtexpr4#11: $state;
  var SL#_dryad_S3: $state;
  var stmtexpr3#10: $state;
  var SL#_dryad_S2: $state;
  var stmtexpr2#9: $state;
  var _dryad_S1#2: $state;
  var stmtexpr1#8: $state;
  var _dryad_S0#1: $state;
  var stmtexpr0#7: $ptr;
  var curr0#0: $ptr;
  var stmtexpr2#6: $ptr;
  var SL#curr0: $ptr;
  var stmtexpr1#5: $state;
  var SL#_dryad_S1: $state;
  var stmtexpr0#4: $state;
  var SL#_dryad_S0: $state;
  var ite#2: bool;
  var ite#1: bool;
  var loopState#0: $state;
  var L#nondet: int where $in_range_i4(L#nondet);
  var L#curr: $ptr;
  var L#curr_next: $ptr;
  var stmtexpr1#13: $oset;
  var stmtexpr0#12: $oset;
  var SL#_dryad_G1: $oset;
  var SL#_dryad_G0: $oset;
  var #wrTime$2^6.3: int;
  var #stackframe: int;

  anon10:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^6.3, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$2^6.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^6.3, (lambda #p: $ptr :: false));
    // assume true
    // assume true
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    //  --- Dryad annotated function --- 
    // _math \oset _dryad_G0; 
    // _math \oset _dryad_G1; 
    // _dryad_G0 := sll_reach(lst); 
    call SL#_dryad_G0 := sll_reach($phys_ptr_cast(P#lst, ^s_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _math \oset stmtexpr0#12; 
    // stmtexpr0#12 := _dryad_G0; 
    stmtexpr0#12 := SL#_dryad_G0;
    // _dryad_G1 := _dryad_G0; 
    SL#_dryad_G1 := SL#_dryad_G0;
    // _math \oset stmtexpr1#13; 
    // stmtexpr1#13 := _dryad_G1; 
    stmtexpr1#13 := SL#_dryad_G1;
    // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
    assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
    assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
    assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
    assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
    assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
    assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(lst), &&(@_vcc_mutable(@state, lst), @writes_check(lst))); 
    assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> $mutable($s, $phys_ptr_cast(P#lst, ^s_node)) && $top_writable($s, #wrTime$2^6.3, $phys_ptr_cast(P#lst, ^s_node));
    assume true;
    // if (@_vcc_ptr_eq_null(lst)) ...
    if ($is_null($phys_ptr_cast(P#lst, ^s_node)))
    {
      anon1:
        // return elt; 
        $result := $phys_ptr_cast(P#elt, ^s_node);
        assume true;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon8:
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
        // struct s_node* curr_next; 
        // struct s_node* curr; 
        // int32_t nondet; 
        // var int32_t nondet
        // curr := lst; 
        L#curr := $phys_ptr_cast(P#lst, ^s_node);
        // assert sll_lseg(curr, curr); 
        assert F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume sll_lseg(curr, curr); 
        assume F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assert sll_lseg(curr_next, curr_next); 
        assert F#sll_lseg($s, $phys_ptr_cast(L#curr_next, ^s_node), $phys_ptr_cast(L#curr_next, ^s_node));
        // assume sll_lseg(curr_next, curr_next); 
        assume F#sll_lseg($s, $phys_ptr_cast(L#curr_next, ^s_node), $phys_ptr_cast(L#curr_next, ^s_node));
        // assert sll_lseg(elt, elt); 
        assert F#sll_lseg($s, $phys_ptr_cast(P#elt, ^s_node), $phys_ptr_cast(P#elt, ^s_node));
        // assume sll_lseg(elt, elt); 
        assume F#sll_lseg($s, $phys_ptr_cast(P#elt, ^s_node), $phys_ptr_cast(P#elt, ^s_node));
        // assert sll_lseg(lst, lst); 
        assert F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(P#lst, ^s_node));
        // assume sll_lseg(lst, lst); 
        assume F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(P#lst, ^s_node));
        loopState#0 := $s;
        assume true;
        while (true)
          invariant $non_null($phys_ptr_cast(L#curr, ^s_node));
          invariant F#sll($s, $phys_ptr_cast(P#lst, ^s_node));
          invariant F#sll($s, $phys_ptr_cast(L#curr, ^s_node));
          invariant F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
          invariant $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)), F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)));
          invariant $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#curr, ^s_node));
          invariant $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $top_writable($s, #wrTime$2^6.3, $phys_ptr_cast(L#curr, ^s_node));
        {
          anon6:
            assume $writes_nothing(old($s), $s);
            assume $timestamp_post(loopState#0, $s);
            assume $full_stop_ext(#tok$2^20.5, $s);
            // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
            assume $meta_eq(loopState#0, $s);
            // _Bool ite#1; 
            // _Bool ite#2; 
            // ite#2 := (_Bool)nondet; 
            ite#2 := $int_to_bool(L#nondet);
            assume true;
            // if (ite#2) ...
            if (ite#2)
            {
              anon2:
                // assert @_vcc_possibly_unreachable; 
                assert {:PossiblyUnreachable true} true;
                // assert @reads_check_normal((curr->next)); 
                assert $thread_local($s, $phys_ptr_cast(L#curr, ^s_node));
                // ite#1 := @_vcc_ptr_neq_null(*((curr->next))); 
                ite#1 := $non_null($rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node));
            }
            else
            {
              anon3:
                // assert @_vcc_possibly_unreachable; 
                assert {:PossiblyUnreachable true} true;
                // ite#1 := false; 
                ite#1 := false;
            }

          anon7:
            assume true;
            // if (ite#1) ...
            if (ite#1)
            {
              anon4:
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
                assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
                assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
                assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
                assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg(lst, curr), &&(sll_lseg(*((lst->next)), curr), unchecked!(@_vcc_oset_in(lst, sll_lseg_reach(*((lst->next)), curr)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_reach(lst, curr), @_vcc_oset_union_one2(sll_lseg_reach(*((lst->next)), curr), lst))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_keys(lst, curr), @_vcc_intset_union(sll_lseg_keys(*((lst->next)), curr), @_vcc_intset_singleton(*((lst->key)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
                // _math \state _dryad_S0; 
                // _dryad_S0 := @_vcc_current_state(@state); 
                SL#_dryad_S0 := $current_state($s);
                // _math \state stmtexpr0#4; 
                // stmtexpr0#4 := _dryad_S0; 
                stmtexpr0#4 := SL#_dryad_S0;
                // nondet := havoc(); 
                call L#nondet := \havoc();
                assume $full_stop_ext(#tok$2^28.16, $s);
                // _math \state _dryad_S1; 
                // _dryad_S1 := @_vcc_current_state(@state); 
                SL#_dryad_S1 := $current_state($s);
                // _math \state stmtexpr1#5; 
                // stmtexpr1#5 := _dryad_S1; 
                stmtexpr1#5 := SL#_dryad_S1;
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
                assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
                assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
                assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
                assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg(lst, curr), &&(sll_lseg(*((lst->next)), curr), unchecked!(@_vcc_oset_in(lst, sll_lseg_reach(*((lst->next)), curr)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_reach(lst, curr), @_vcc_oset_union_one2(sll_lseg_reach(*((lst->next)), curr), lst))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_keys(lst, curr), @_vcc_intset_union(sll_lseg_keys(*((lst->next)), curr), @_vcc_intset_singleton(*((lst->key)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
                // struct s_node* curr0; 
                // curr0 := curr; 
                SL#curr0 := $phys_ptr_cast(L#curr, ^s_node);
                // struct s_node* stmtexpr2#6; 
                // stmtexpr2#6 := curr0; 
                stmtexpr2#6 := $phys_ptr_cast(SL#curr0, ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(curr), @_vcc_ptr_neq_pure(curr, *((curr->next)))), ==(sll_lseg(curr, *((curr->next))), &&(sll_lseg(*((curr->next)), *((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_lseg_reach(*((curr->next)), *((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) && $phys_ptr_cast(L#curr, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(curr), @_vcc_ptr_neq_pure(curr, *((curr->next)))), ==(sll_lseg_reach(curr, *((curr->next))), @_vcc_oset_union_one2(sll_lseg_reach(*((curr->next)), *((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) && $phys_ptr_cast(L#curr, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#curr, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(curr), @_vcc_ptr_neq_pure(curr, *((curr->next)))), ==(sll_lseg_keys(curr, *((curr->next))), @_vcc_intset_union(sll_lseg_keys(*((curr->next)), *((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) && $phys_ptr_cast(L#curr, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#curr, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assert @reads_check_normal((curr->next)); 
                assert $thread_local($s, $phys_ptr_cast(L#curr, ^s_node));
                // curr := *((curr->next)); 
                L#curr := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg(lst, curr), &&(sll_lseg(*((lst->next)), curr), unchecked!(@_vcc_oset_in(lst, sll_lseg_reach(*((lst->next)), curr)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_reach(lst, curr), @_vcc_oset_union_one2(sll_lseg_reach(*((lst->next)), curr), lst))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_keys(lst, curr), @_vcc_intset_union(sll_lseg_keys(*((lst->next)), curr), @_vcc_intset_singleton(*((lst->key)))))); 
                assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), &&(@_vcc_mutable(@state, curr), @writes_check(curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#curr, ^s_node)) && $top_writable($s, #wrTime$2^6.3, $phys_ptr_cast(L#curr, ^s_node));
            }
            else
            {
              anon5:
                // assert @_vcc_possibly_unreachable; 
                assert {:PossiblyUnreachable true} true;
                // goto #break_3; 
                goto #break_3;
            }

          #continue_3:
            assume true;
        }

      anon9:
        assume $full_stop_ext(#tok$2^20.5, $s);

      #break_3:
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
        // struct s_node* curr0#0; 
        // curr0#0 := curr; 
        curr0#0 := $phys_ptr_cast(L#curr, ^s_node);
        // struct s_node* stmtexpr0#7; 
        // stmtexpr0#7 := curr0#0; 
        stmtexpr0#7 := $phys_ptr_cast(curr0#0, ^s_node);
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
        // assert @reads_check_normal((curr->next)); 
        assert $thread_local($s, $phys_ptr_cast(L#curr, ^s_node));
        // curr_next := *((curr->next)); 
        L#curr_next := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node);
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
        // _math \state _dryad_S0#1; 
        // _dryad_S0#1 := @_vcc_current_state(@state); 
        _dryad_S0#1 := $current_state($s);
        // _math \state stmtexpr1#8; 
        // stmtexpr1#8 := _dryad_S0#1; 
        stmtexpr1#8 := _dryad_S0#1;
        // assert @prim_writes_check((elt->next)); 
        assert $writable_prim($s, #wrTime$2^6.3, $dot($phys_ptr_cast(P#elt, ^s_node), s_node.next));
        // *(elt->next) := curr_next; 
        call $write_int(s_node.next, $phys_ptr_cast(P#elt, ^s_node), $ptr_to_int($phys_ptr_cast(L#curr_next, ^s_node)));
        assume $full_stop_ext(#tok$2^33.5, $s);
        // _math \state _dryad_S1#2; 
        // _dryad_S1#2 := @_vcc_current_state(@state); 
        _dryad_S1#2 := $current_state($s);
        // _math \state stmtexpr2#9; 
        // stmtexpr2#9 := _dryad_S1#2; 
        stmtexpr2#9 := _dryad_S1#2;
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr0#0)))), ==(old(_dryad_S0#1, sll_keys(curr0#0)), old(_dryad_S1#2, sll_keys(curr0#0)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(curr0#0, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(curr0#0, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr0#0)))), ==(old(_dryad_S0#1, sll(curr0#0)), old(_dryad_S1#2, sll(curr0#0)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(curr0#0, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(curr0#0, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr0#0)))), ==(old(_dryad_S0#1, sll_reach(curr0#0)), old(_dryad_S1#2, sll_reach(curr0#0)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(curr0#0, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(curr0#0, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr)))), ==(old(_dryad_S0#1, sll_keys(curr)), old(_dryad_S1#2, sll_keys(curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr)))), ==(old(_dryad_S0#1, sll(curr)), old(_dryad_S1#2, sll(curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr)))), ==(old(_dryad_S0#1, sll_reach(curr)), old(_dryad_S1#2, sll_reach(curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr_next)))), ==(old(_dryad_S0#1, sll_keys(curr_next)), old(_dryad_S1#2, sll_keys(curr_next)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr_next, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(L#curr_next, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr_next)))), ==(old(_dryad_S0#1, sll(curr_next)), old(_dryad_S1#2, sll(curr_next)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr_next, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(L#curr_next, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(curr_next)))), ==(old(_dryad_S0#1, sll_reach(curr_next)), old(_dryad_S1#2, sll_reach(curr_next)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr_next, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr_next, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(lst)))), ==(old(_dryad_S0#1, sll_keys(lst)), old(_dryad_S1#2, sll_keys(lst)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(lst)))), ==(old(_dryad_S0#1, sll(lst)), old(_dryad_S1#2, sll(lst)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_reach(lst)))), ==(old(_dryad_S0#1, sll_reach(lst)), old(_dryad_S1#2, sll_reach(lst)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S0#1, sll_lseg(lst, curr)), old(_dryad_S1#2, sll_lseg(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S0#1, sll_lseg_reach(lst, curr)), old(_dryad_S1#2, sll_lseg_reach(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_reach(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S0#1, sll_lseg_keys(lst, curr)), old(_dryad_S1#2, sll_lseg_keys(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_keys(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S0#1, sll_lseg(lst, curr)), old(_dryad_S1#2, sll_lseg(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S0#1, sll_lseg_reach(lst, curr)), old(_dryad_S1#2, sll_lseg_reach(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_reach(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(elt, old(_dryad_S0#1, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S0#1, sll_lseg_keys(lst, curr)), old(_dryad_S1#2, sll_lseg_keys(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#1, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_keys(_dryad_S1#2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, curr0#0)), ==(*((curr0#0->key)), old(_dryad_S0#1, *((curr0#0->key))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(curr0#0, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(curr0#0, ^s_node)) == $rd_inv(_dryad_S0#1, s_node.key, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, curr0#0)), @_vcc_ptr_eq_pure(*((curr0#0->next)), old(_dryad_S0#1, *((curr0#0->next))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(curr0#0, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#1, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node);
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, curr)), ==(*((curr->key)), old(_dryad_S0#1, *((curr->key))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(L#curr, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node)) == $rd_inv(_dryad_S0#1, s_node.key, $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, curr)), @_vcc_ptr_eq_pure(*((curr->next)), old(_dryad_S0#1, *((curr->next))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(L#curr, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#1, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node);
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, curr_next)), ==(*((curr_next->key)), old(_dryad_S0#1, *((curr_next->key))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(L#curr_next, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node)) == $rd_inv(_dryad_S0#1, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, curr_next)), @_vcc_ptr_eq_pure(*((curr_next->next)), old(_dryad_S0#1, *((curr_next->next))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(L#curr_next, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#1, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node);
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, lst)), ==(*((lst->key)), old(_dryad_S0#1, *((lst->key))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(P#lst, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node)) == $rd_inv(_dryad_S0#1, s_node.key, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(elt, lst)), @_vcc_ptr_eq_pure(*((lst->next)), old(_dryad_S0#1, *((lst->next))))); 
        assume !($phys_ptr_cast(P#elt, ^s_node) == $phys_ptr_cast(P#lst, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node) == $rd_phys_ptr(_dryad_S0#1, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node);
        // assume ==>(@_vcc_ptr_neq_null(curr0#0), ==(sll_keys(curr0#0), @_vcc_intset_union(sll_keys(*((curr0#0->next))), @_vcc_intset_singleton(*((curr0#0->key)))))); 
        assume $non_null($phys_ptr_cast(curr0#0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(curr0#0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(curr0#0, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr0#0), ==(sll(curr0#0), &&(sll(*((curr0#0->next))), unchecked!(@_vcc_oset_in(curr0#0, sll_reach(*((curr0#0->next)))))))); 
        assume $non_null($phys_ptr_cast(curr0#0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(curr0#0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(curr0#0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr0#0), ==(sll_reach(curr0#0), @_vcc_oset_union_one2(sll_reach(*((curr0#0->next))), curr0#0))); 
        assume $non_null($phys_ptr_cast(curr0#0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(curr0#0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node)), $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg(lst, curr), &&(sll_lseg(*((lst->next)), curr), unchecked!(@_vcc_oset_in(lst, sll_lseg_reach(*((lst->next)), curr)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_reach(lst, curr), @_vcc_oset_union_one2(sll_lseg_reach(*((lst->next)), curr), lst))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_keys(lst, curr), @_vcc_intset_union(sll_lseg_keys(*((lst->next)), curr), @_vcc_intset_singleton(*((lst->key)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
        // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg(lst, curr), &&(sll_lseg(*((lst->next)), curr), unchecked!(@_vcc_oset_in(lst, sll_lseg_reach(*((lst->next)), curr)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_reach(lst, curr), @_vcc_oset_union_one2(sll_lseg_reach(*((lst->next)), curr), lst))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(&&(@_vcc_ptr_neq_null(lst), @_vcc_ptr_neq_pure(lst, curr)), ==(sll_lseg_keys(lst, curr), @_vcc_intset_union(sll_lseg_keys(*((lst->next)), curr), @_vcc_intset_singleton(*((lst->key)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) && $phys_ptr_cast(P#lst, ^s_node) != $phys_ptr_cast(L#curr, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node), $phys_ptr_cast(L#curr, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
        // _math \state _dryad_S2; 
        // _dryad_S2 := @_vcc_current_state(@state); 
        SL#_dryad_S2 := $current_state($s);
        // _math \state stmtexpr3#10; 
        // stmtexpr3#10 := _dryad_S2; 
        stmtexpr3#10 := SL#_dryad_S2;
        // assert @prim_writes_check((curr->next)); 
        assert $writable_prim($s, #wrTime$2^6.3, $dot($phys_ptr_cast(L#curr, ^s_node), s_node.next));
        // *(curr->next) := elt; 
        call $write_int(s_node.next, $phys_ptr_cast(L#curr, ^s_node), $ptr_to_int($phys_ptr_cast(P#elt, ^s_node)));
        assume $full_stop_ext(#tok$2^34.5, $s);
        // _math \state _dryad_S3; 
        // _dryad_S3 := @_vcc_current_state(@state); 
        SL#_dryad_S3 := $current_state($s);
        // _math \state stmtexpr4#11; 
        // stmtexpr4#11 := _dryad_S3; 
        stmtexpr4#11 := SL#_dryad_S3;
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(curr0#0)))), ==(old(_dryad_S2, sll_keys(curr0#0)), old(_dryad_S3, sll_keys(curr0#0)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(curr0#0, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(curr0#0, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(curr0#0)))), ==(old(_dryad_S2, sll(curr0#0)), old(_dryad_S3, sll(curr0#0)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(curr0#0, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(curr0#0, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(curr0#0)))), ==(old(_dryad_S2, sll_reach(curr0#0)), old(_dryad_S3, sll_reach(curr0#0)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(curr0#0, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(curr0#0, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(curr_next)))), ==(old(_dryad_S2, sll_keys(curr_next)), old(_dryad_S3, sll_keys(curr_next)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#curr_next, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(L#curr_next, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(curr_next)))), ==(old(_dryad_S2, sll(curr_next)), old(_dryad_S3, sll(curr_next)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#curr_next, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(L#curr_next, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(curr_next)))), ==(old(_dryad_S2, sll_reach(curr_next)), old(_dryad_S3, sll_reach(curr_next)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#curr_next, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#curr_next, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(elt)))), ==(old(_dryad_S2, sll_keys(elt)), old(_dryad_S3, sll_keys(elt)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#elt, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(P#elt, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(elt)))), ==(old(_dryad_S2, sll(elt)), old(_dryad_S3, sll(elt)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#elt, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(P#elt, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(elt)))), ==(old(_dryad_S2, sll_reach(elt)), old(_dryad_S3, sll_reach(elt)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#elt, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#elt, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(lst)))), ==(old(_dryad_S2, sll_keys(lst)), old(_dryad_S3, sll_keys(lst)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(lst)))), ==(old(_dryad_S2, sll(lst)), old(_dryad_S3, sll(lst)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_reach(lst)))), ==(old(_dryad_S2, sll_reach(lst)), old(_dryad_S3, sll_reach(lst)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S2, sll_lseg(lst, curr)), old(_dryad_S3, sll_lseg(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S2, sll_lseg_reach(lst, curr)), old(_dryad_S3, sll_lseg_reach(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S2, sll_lseg_keys(lst, curr)), old(_dryad_S3, sll_lseg_keys(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S2, sll_lseg(lst, curr)), old(_dryad_S3, sll_lseg(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S2, sll_lseg_reach(lst, curr)), old(_dryad_S3, sll_lseg_reach(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(unchecked!(@_vcc_oset_in(curr, old(_dryad_S2, sll_lseg_reach(lst, curr)))), ==(old(_dryad_S2, sll_lseg_keys(lst, curr)), old(_dryad_S3, sll_lseg_keys(lst, curr)))); 
        assume !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S2, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S3, $phys_ptr_cast(P#lst, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, curr0#0)), ==(*((curr0#0->key)), old(_dryad_S2, *((curr0#0->key))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(curr0#0, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(curr0#0, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, curr0#0)), @_vcc_ptr_eq_pure(*((curr0#0->next)), old(_dryad_S2, *((curr0#0->next))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(curr0#0, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node);
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, curr_next)), ==(*((curr_next->key)), old(_dryad_S2, *((curr_next->key))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(L#curr_next, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, curr_next)), @_vcc_ptr_eq_pure(*((curr_next->next)), old(_dryad_S2, *((curr_next->next))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(L#curr_next, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node);
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, elt)), ==(*((elt->key)), old(_dryad_S2, *((elt->key))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(P#elt, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, elt)), @_vcc_ptr_eq_pure(*((elt->next)), old(_dryad_S2, *((elt->next))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(P#elt, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node);
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, lst)), ==(*((lst->key)), old(_dryad_S2, *((lst->key))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(P#lst, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(!(@_vcc_ptr_eq_pure(curr, lst)), @_vcc_ptr_eq_pure(*((lst->next)), old(_dryad_S2, *((lst->next))))); 
        assume !($phys_ptr_cast(L#curr, ^s_node) == $phys_ptr_cast(P#lst, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node);
        // assume ==>(@_vcc_ptr_neq_null(curr0#0), ==(sll_keys(curr0#0), @_vcc_intset_union(sll_keys(*((curr0#0->next))), @_vcc_intset_singleton(*((curr0#0->key)))))); 
        assume $non_null($phys_ptr_cast(curr0#0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(curr0#0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(curr0#0, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr0#0), ==(sll(curr0#0), &&(sll(*((curr0#0->next))), unchecked!(@_vcc_oset_in(curr0#0, sll_reach(*((curr0#0->next)))))))); 
        assume $non_null($phys_ptr_cast(curr0#0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(curr0#0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(curr0#0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr0#0), ==(sll_reach(curr0#0), @_vcc_oset_union_one2(sll_reach(*((curr0#0->next))), curr0#0))); 
        assume $non_null($phys_ptr_cast(curr0#0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(curr0#0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(curr0#0, ^s_node), ^s_node)), $phys_ptr_cast(curr0#0, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_keys(curr_next), @_vcc_intset_union(sll_keys(*((curr_next->next))), @_vcc_intset_singleton(*((curr_next->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr_next, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll(curr_next), &&(sll(*((curr_next->next))), unchecked!(@_vcc_oset_in(curr_next, sll_reach(*((curr_next->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr_next), ==(sll_reach(curr_next), @_vcc_oset_union_one2(sll_reach(*((curr_next->next))), curr_next))); 
        assume $non_null($phys_ptr_cast(L#curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#curr_next, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_keys(lst), @_vcc_intset_union(sll_keys(*((lst->next))), @_vcc_intset_singleton(*((lst->key)))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#lst, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#lst, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll(lst), &&(sll(*((lst->next))), unchecked!(@_vcc_oset_in(lst, sll_reach(*((lst->next)))))))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#lst, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#lst, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(lst), ==(sll_reach(lst), @_vcc_oset_union_one2(sll_reach(*((lst->next))), lst))); 
        assume $non_null($phys_ptr_cast(P#lst, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#lst, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#lst, ^s_node), ^s_node)), $phys_ptr_cast(P#lst, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
        assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_keys(elt), @_vcc_intset_union(sll_keys(*((elt->next))), @_vcc_intset_singleton(*((elt->key)))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#elt, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#elt, ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll(elt), &&(sll(*((elt->next))), unchecked!(@_vcc_oset_in(elt, sll_reach(*((elt->next)))))))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#elt, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#elt, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node))));
        // assume ==>(@_vcc_ptr_neq_null(elt), ==(sll_reach(elt), @_vcc_oset_union_one2(sll_reach(*((elt->next))), elt))); 
        assume $non_null($phys_ptr_cast(P#elt, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#elt, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#elt, ^s_node), ^s_node)), $phys_ptr_cast(P#elt, ^s_node));
        // return lst; 
        $result := $phys_ptr_cast(P#lst, ^s_node);
        assume true;
        assert $position_marker();
        goto #exit;
    }

  anon11:
    // skip

  #exit:
}



const unique l#public: $label;

const unique #tok$2^34.5: $token;

const unique #tok$2^33.5: $token;

const unique #tok$2^28.16: $token;

const unique #tok$2^20.5: $token;

const unique #tok$3^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(3, #file^?3Cno?20file?3E);

const unique #tok$2^6.3: $token;

const unique #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Csl?5Csl_insert.c: $token;

axiom $file_name_is(2, #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Csl?5Csl_insert.c);

const unique #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Csl?5Cdryad_sl.h: $token;

axiom $file_name_is(1, #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Csl?5Cdryad_sl.h);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^s_node);
