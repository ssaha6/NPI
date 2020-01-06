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

const unique ^$#sl_filter.c..36263#3: $ctype;

axiom $def_fnptr_type(^$#sl_filter.c..36263#3);

type $#sl_filter.c..36263#3;

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



procedure sl_filter(P#x: $ptr) returns ($result: $ptr);
  requires F#sll($s, $phys_ptr_cast(P#x, ^s_node));
  modifies $s, $cev_pc;
  ensures F#sll($s, $phys_ptr_cast($result, ^s_node));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation sl_filter(P#x: $ptr) returns ($result: $ptr)
{
  var stmtexpr1#9: $state;
  var _dryad_S1#2: $state;
  var stmtexpr0#8: $state;
  var _dryad_S0#1: $state;
  var stmtexpr0#7: $ptr;
  var old_curr1#0: $ptr;
  var stmtexpr2#6: $state;
  var SL#_dryad_S1: $state;
  var stmtexpr1#5: $state;
  var SL#_dryad_S0: $state;
  var stmtexpr0#4: $ptr;
  var SL#old_curr1: $ptr;
  var L#old_curr_next: $ptr;
  var ite#1: bool;
  var stmtexpr0#3: $ptr;
  var SL#curr0: $ptr;
  var L#old_curr: $ptr;
  var L#nondet: int where $in_range_i4(L#nondet);
  var loopState#0: $state;
  var L#prv: $ptr;
  var L#curr: $ptr;
  var L#res: $ptr;
  var stmtexpr1#11: $oset;
  var stmtexpr0#10: $oset;
  var SL#_dryad_G1: $oset;
  var SL#_dryad_G0: $oset;
  var #wrTime$2^3.3: int;
  var #stackframe: int;

  anon9:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^3.3, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$2^3.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^3.3, (lambda #p: $ptr :: false));
    // assume true
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    //  --- Dryad annotated function --- 
    // _math \oset _dryad_G0; 
    // _math \oset _dryad_G1; 
    // _dryad_G0 := sll_reach(x); 
    call SL#_dryad_G0 := sll_reach($phys_ptr_cast(P#x, ^s_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _math \oset stmtexpr0#10; 
    // stmtexpr0#10 := _dryad_G0; 
    stmtexpr0#10 := SL#_dryad_G0;
    // _dryad_G1 := _dryad_G0; 
    SL#_dryad_G1 := SL#_dryad_G0;
    // _math \oset stmtexpr1#11; 
    // stmtexpr1#11 := _dryad_G1; 
    stmtexpr1#11 := SL#_dryad_G1;
    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
    // struct s_node* res; 
    // struct s_node* curr; 
    // struct s_node* prv; 
    // assume ==>(@_vcc_ptr_neq_null(x), &&(@_vcc_mutable(@state, x), @writes_check(x))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> $mutable($s, $phys_ptr_cast(P#x, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(P#x, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(x), @_vcc_is_malloc_root(@state, x)); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> $is_malloc_root($s, $phys_ptr_cast(P#x, ^s_node));
    // prv := (struct s_node*)@null; 
    L#prv := $phys_ptr_cast($null, ^s_node);
    // assert sll_lseg(prv, prv); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
    // assume sll_lseg(prv, prv); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
    // assert sll_lseg(curr, curr); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
    // assume sll_lseg(curr, curr); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
    // assert sll_lseg(res, res); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume sll_lseg(res, res); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert sll_lseg(x, x); 
    assert F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
    // assume sll_lseg(x, x); 
    assume F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
    // curr := x; 
    L#curr := $phys_ptr_cast(P#x, ^s_node);
    // assert sll_lseg(prv, prv); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
    // assume sll_lseg(prv, prv); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
    // assert sll_lseg(curr, curr); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
    // assume sll_lseg(curr, curr); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
    // assert sll_lseg(res, res); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume sll_lseg(res, res); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert sll_lseg(x, x); 
    assert F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
    // assume sll_lseg(x, x); 
    assume F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
    // res := x; 
    L#res := $phys_ptr_cast(P#x, ^s_node);
    // assert sll_lseg(prv, prv); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
    // assume sll_lseg(prv, prv); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
    // assert sll_lseg(curr, curr); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
    // assume sll_lseg(curr, curr); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
    // assert sll_lseg(res, res); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assume sll_lseg(res, res); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
    // assert sll_lseg(x, x); 
    assert F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
    // assume sll_lseg(x, x); 
    assume F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
    loopState#0 := $s;
    assume true;
    while (true)
      invariant F#sll($s, $phys_ptr_cast(L#prv, ^s_node));
      invariant F#sll($s, $phys_ptr_cast(L#res, ^s_node));
      invariant F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
      invariant $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)), F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)));
      invariant $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node) == $phys_ptr_cast(L#curr, ^s_node);
      invariant $is_null($phys_ptr_cast(L#prv, ^s_node)) ==> $phys_ptr_cast(L#res, ^s_node) == $phys_ptr_cast(L#curr, ^s_node);
      invariant $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#prv, ^s_node));
      invariant $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#prv, ^s_node));
      invariant $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#curr, ^s_node));
      invariant $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#curr, ^s_node));
      invariant $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $is_malloc_root($s, $phys_ptr_cast(L#curr, ^s_node));
    {
      anon8:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$2^13.3, $s);
        assume true;
        // if (@_vcc_ptr_neq_null(curr)) ...
        if ($non_null($phys_ptr_cast(L#curr, ^s_node)))
        {
          anon6:
            // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
            assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
            assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
            assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
            assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
            assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
            assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
            assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
            assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
            assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg(res, prv), &&(sll_lseg(*((res->next)), prv), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), prv)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_reach(res, prv), @_vcc_oset_union_one2(sll_lseg_reach(*((res->next)), prv), res))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $phys_ptr_cast(L#res, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_keys(res, prv), @_vcc_intset_union(sll_lseg_keys(*((res->next)), prv), @_vcc_intset_singleton(*((res->key)))))); 
            assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
            // int32_t nondet; 
            // struct s_node* old_curr; 
            // old_curr := curr; 
            L#old_curr := $phys_ptr_cast(L#curr, ^s_node);
            // assert sll_lseg(old_curr, old_curr); 
            assert F#sll_lseg($s, $phys_ptr_cast(L#old_curr, ^s_node), $phys_ptr_cast(L#old_curr, ^s_node));
            // assume sll_lseg(old_curr, old_curr); 
            assume F#sll_lseg($s, $phys_ptr_cast(L#old_curr, ^s_node), $phys_ptr_cast(L#old_curr, ^s_node));
            // assert sll_lseg(prv, prv); 
            assert F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
            // assume sll_lseg(prv, prv); 
            assume F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
            // assert sll_lseg(curr, curr); 
            assert F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
            // assume sll_lseg(curr, curr); 
            assume F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
            // assert sll_lseg(res, res); 
            assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
            // assume sll_lseg(res, res); 
            assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
            // assert sll_lseg(x, x); 
            assert F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
            // assume sll_lseg(x, x); 
            assume F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
            // struct s_node* curr0; 
            // curr0 := curr; 
            SL#curr0 := $phys_ptr_cast(L#curr, ^s_node);
            // struct s_node* stmtexpr0#3; 
            // stmtexpr0#3 := curr0; 
            stmtexpr0#3 := $phys_ptr_cast(SL#curr0, ^s_node);
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
            // assume ==>(@_vcc_ptr_neq_null(curr), &&(@_vcc_mutable(@state, curr), @writes_check(curr))); 
            assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#curr, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#curr, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(curr), @_vcc_is_malloc_root(@state, curr)); 
            assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> $is_malloc_root($s, $phys_ptr_cast(L#curr, ^s_node));
            // var int32_t nondet
            // _Bool ite#1; 
            // ite#1 := (_Bool)nondet; 
            ite#1 := $int_to_bool(L#nondet);
            assume true;
            // if (ite#1) ...
            if (ite#1)
            {
              anon3:
                // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_keys(curr0), @_vcc_intset_union(sll_keys(*((curr0->next))), @_vcc_intset_singleton(*((curr0->key)))))); 
                assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll(curr0), &&(sll(*((curr0->next))), unchecked!(@_vcc_oset_in(curr0, sll_reach(*((curr0->next)))))))); 
                assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SL#curr0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(SL#curr0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_reach(curr0), @_vcc_oset_union_one2(sll_reach(*((curr0->next))), curr0))); 
                assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $phys_ptr_cast(SL#curr0, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
                assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
                assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
                assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
                assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
                assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
                assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg(res, prv), &&(sll_lseg(*((res->next)), prv), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), prv)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_reach(res, prv), @_vcc_oset_union_one2(sll_lseg_reach(*((res->next)), prv), res))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_keys(res, prv), @_vcc_intset_union(sll_lseg_keys(*((res->next)), prv), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                assume true;
                // if (@_vcc_ptr_neq_null(prv)) ...
                if ($non_null($phys_ptr_cast(L#prv, ^s_node)))
                {
                  anon1:
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_keys(curr0), @_vcc_intset_union(sll_keys(*((curr0->next))), @_vcc_intset_singleton(*((curr0->key)))))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll(curr0), &&(sll(*((curr0->next))), unchecked!(@_vcc_oset_in(curr0, sll_reach(*((curr0->next)))))))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SL#curr0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(SL#curr0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_reach(curr0), @_vcc_oset_union_one2(sll_reach(*((curr0->next))), curr0))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg(res, prv), &&(sll_lseg(*((res->next)), prv), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), prv)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node))));
                    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_reach(res, prv), @_vcc_oset_union_one2(sll_lseg_reach(*((res->next)), prv), res))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_keys(res, prv), @_vcc_intset_union(sll_lseg_keys(*((res->next)), prv), @_vcc_intset_singleton(*((res->key)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                    // struct s_node* old_curr_next; 
                    // struct s_node* old_curr1; 
                    // old_curr1 := old_curr; 
                    SL#old_curr1 := $phys_ptr_cast(L#old_curr, ^s_node);
                    // struct s_node* stmtexpr0#4; 
                    // stmtexpr0#4 := old_curr1; 
                    stmtexpr0#4 := $phys_ptr_cast(SL#old_curr1, ^s_node);
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                    // assert @reads_check_normal((old_curr->next)); 
                    assert $thread_local($s, $phys_ptr_cast(L#old_curr, ^s_node));
                    // old_curr_next := *((old_curr->next)); 
                    L#old_curr_next := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node);
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll_keys(old_curr_next), @_vcc_intset_union(sll_keys(*((old_curr_next->next))), @_vcc_intset_singleton(*((old_curr_next->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr_next, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll(old_curr_next), &&(sll(*((old_curr_next->next))), unchecked!(@_vcc_oset_in(old_curr_next, sll_reach(*((old_curr_next->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll_reach(old_curr_next), @_vcc_oset_union_one2(sll_reach(*((old_curr_next->next))), old_curr_next))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr_next, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                    // _math \state _dryad_S0; 
                    // _dryad_S0 := @_vcc_current_state(@state); 
                    SL#_dryad_S0 := $current_state($s);
                    // _math \state stmtexpr1#5; 
                    // stmtexpr1#5 := _dryad_S0; 
                    stmtexpr1#5 := SL#_dryad_S0;
                    // assert @prim_writes_check((prv->next)); 
                    assert $writable_prim($s, #wrTime$2^3.3, $dot($phys_ptr_cast(L#prv, ^s_node), s_node.next));
                    // *(prv->next) := old_curr_next; 
                    call $write_int(s_node.next, $phys_ptr_cast(L#prv, ^s_node), $ptr_to_int($phys_ptr_cast(L#old_curr_next, ^s_node)));
                    assume $full_stop_ext(#tok$2^33.9, $s);
                    // _math \state _dryad_S1; 
                    // _dryad_S1 := @_vcc_current_state(@state); 
                    SL#_dryad_S1 := $current_state($s);
                    // _math \state stmtexpr2#6; 
                    // stmtexpr2#6 := _dryad_S1; 
                    stmtexpr2#6 := SL#_dryad_S1;
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr1)))), ==(old(_dryad_S0, sll_keys(old_curr1)), old(_dryad_S1, sll_keys(old_curr1)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#old_curr1, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(SL#old_curr1, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(SL#old_curr1, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr1)))), ==(old(_dryad_S0, sll(old_curr1)), old(_dryad_S1, sll(old_curr1)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#old_curr1, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(SL#old_curr1, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(SL#old_curr1, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr1)))), ==(old(_dryad_S0, sll_reach(old_curr1)), old(_dryad_S1, sll_reach(old_curr1)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#old_curr1, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#old_curr1, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(SL#old_curr1, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr_next)))), ==(old(_dryad_S0, sll_keys(old_curr_next)), old(_dryad_S1, sll_keys(old_curr_next)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr_next, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#old_curr_next, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#old_curr_next, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr_next)))), ==(old(_dryad_S0, sll(old_curr_next)), old(_dryad_S1, sll(old_curr_next)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr_next, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#old_curr_next, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#old_curr_next, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr_next)))), ==(old(_dryad_S0, sll_reach(old_curr_next)), old(_dryad_S1, sll_reach(old_curr_next)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr_next, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr_next, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#old_curr_next, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(curr0)))), ==(old(_dryad_S0, sll_keys(curr0)), old(_dryad_S1, sll_keys(curr0)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#curr0, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(SL#curr0, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(curr0)))), ==(old(_dryad_S0, sll(curr0)), old(_dryad_S1, sll(curr0)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#curr0, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(SL#curr0, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(curr0)))), ==(old(_dryad_S0, sll_reach(curr0)), old(_dryad_S1, sll_reach(curr0)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#curr0, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#curr0, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr)))), ==(old(_dryad_S0, sll_keys(old_curr)), old(_dryad_S1, sll_keys(old_curr)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#old_curr, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr)))), ==(old(_dryad_S0, sll(old_curr)), old(_dryad_S1, sll(old_curr)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#old_curr, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(old_curr)))), ==(old(_dryad_S0, sll_reach(old_curr)), old(_dryad_S1, sll_reach(old_curr)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#old_curr, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(curr)))), ==(old(_dryad_S0, sll_keys(curr)), old(_dryad_S1, sll_keys(curr)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#curr, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(curr)))), ==(old(_dryad_S0, sll(curr)), old(_dryad_S1, sll(curr)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#curr, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(curr)))), ==(old(_dryad_S0, sll_reach(curr)), old(_dryad_S1, sll_reach(curr)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#curr, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_keys(res)), old(_dryad_S1, sll_keys(res)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll(res)), old(_dryad_S1, sll(res)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(res)))), ==(old(_dryad_S0, sll_reach(res)), old(_dryad_S1, sll_reach(res)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(x)))), ==(old(_dryad_S0, sll_keys(x)), old(_dryad_S1, sll_keys(x)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(P#x, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(P#x, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(x)))), ==(old(_dryad_S0, sll(x)), old(_dryad_S1, sll(x)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(P#x, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(P#x, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_reach(x)))), ==(old(_dryad_S0, sll_reach(x)), old(_dryad_S1, sll_reach(x)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(P#x, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(P#x, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_lseg_reach(res, prv)))), ==(old(_dryad_S0, sll_lseg(res, prv)), old(_dryad_S1, sll_lseg(res, prv)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_lseg_reach(res, prv)))), ==(old(_dryad_S0, sll_lseg_reach(res, prv)), old(_dryad_S1, sll_lseg_reach(res, prv)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                    // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, sll_lseg_reach(res, prv)))), ==(old(_dryad_S0, sll_lseg_keys(res, prv)), old(_dryad_S1, sll_lseg_keys(res, prv)))); 
                    assume !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, old_curr1)), ==(*((old_curr1->key)), old(_dryad_S0, *((old_curr1->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(SL#old_curr1, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(SL#old_curr1, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(SL#old_curr1, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, old_curr1)), @_vcc_ptr_eq_pure(*((old_curr1->next)), old(_dryad_S0, *((old_curr1->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(SL#old_curr1, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#old_curr1, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(SL#old_curr1, ^s_node), ^s_node);
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, old_curr_next)), ==(*((old_curr_next->key)), old(_dryad_S0, *((old_curr_next->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#old_curr_next, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(L#old_curr_next, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, old_curr_next)), @_vcc_ptr_eq_pure(*((old_curr_next->next)), old(_dryad_S0, *((old_curr_next->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#old_curr_next, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node);
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, curr0)), ==(*((curr0->key)), old(_dryad_S0, *((curr0->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(SL#curr0, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, curr0)), @_vcc_ptr_eq_pure(*((curr0->next)), old(_dryad_S0, *((curr0->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(SL#curr0, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node);
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, old_curr)), ==(*((old_curr->key)), old(_dryad_S0, *((old_curr->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#old_curr, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, old_curr)), @_vcc_ptr_eq_pure(*((old_curr->next)), old(_dryad_S0, *((old_curr->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#old_curr, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node);
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, curr)), ==(*((curr->key)), old(_dryad_S0, *((curr->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#curr, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, curr)), @_vcc_ptr_eq_pure(*((curr->next)), old(_dryad_S0, *((curr->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#curr, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node);
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, res)), ==(*((res->key)), old(_dryad_S0, *((res->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#res, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, res)), @_vcc_ptr_eq_pure(*((res->next)), old(_dryad_S0, *((res->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(L#res, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node);
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, x)), ==(*((x->key)), old(_dryad_S0, *((x->key))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(P#x, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node)) == $rd_inv(SL#_dryad_S0, s_node.key, $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(!(@_vcc_ptr_eq_pure(prv, x)), @_vcc_ptr_eq_pure(*((x->next)), old(_dryad_S0, *((x->next))))); 
                    assume !($phys_ptr_cast(L#prv, ^s_node) == $phys_ptr_cast(P#x, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S0, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node);
                    // assume ==>(@_vcc_ptr_neq_null(old_curr1), ==(sll_keys(old_curr1), @_vcc_intset_union(sll_keys(*((old_curr1->next))), @_vcc_intset_singleton(*((old_curr1->key)))))); 
                    assume $non_null($phys_ptr_cast(SL#old_curr1, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(SL#old_curr1, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#old_curr1, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SL#old_curr1, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr1), ==(sll(old_curr1), &&(sll(*((old_curr1->next))), unchecked!(@_vcc_oset_in(old_curr1, sll_reach(*((old_curr1->next)))))))); 
                    assume $non_null($phys_ptr_cast(SL#old_curr1, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SL#old_curr1, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#old_curr1, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(SL#old_curr1, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#old_curr1, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr1), ==(sll_reach(old_curr1), @_vcc_oset_union_one2(sll_reach(*((old_curr1->next))), old_curr1))); 
                    assume $non_null($phys_ptr_cast(SL#old_curr1, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(SL#old_curr1, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#old_curr1, ^s_node), ^s_node)), $phys_ptr_cast(SL#old_curr1, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll_keys(old_curr_next), @_vcc_intset_union(sll_keys(*((old_curr_next->next))), @_vcc_intset_singleton(*((old_curr_next->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr_next, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll(old_curr_next), &&(sll(*((old_curr_next->next))), unchecked!(@_vcc_oset_in(old_curr_next, sll_reach(*((old_curr_next->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll_reach(old_curr_next), @_vcc_oset_union_one2(sll_reach(*((old_curr_next->next))), old_curr_next))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr_next, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_keys(curr0), @_vcc_intset_union(sll_keys(*((curr0->next))), @_vcc_intset_singleton(*((curr0->key)))))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll(curr0), &&(sll(*((curr0->next))), unchecked!(@_vcc_oset_in(curr0, sll_reach(*((curr0->next)))))))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SL#curr0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(SL#curr0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_reach(curr0), @_vcc_oset_union_one2(sll_reach(*((curr0->next))), curr0))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll_keys(old_curr_next), @_vcc_intset_union(sll_keys(*((old_curr_next->next))), @_vcc_intset_singleton(*((old_curr_next->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr_next, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll(old_curr_next), &&(sll(*((old_curr_next->next))), unchecked!(@_vcc_oset_in(old_curr_next, sll_reach(*((old_curr_next->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr_next, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr_next), ==(sll_reach(old_curr_next), @_vcc_oset_union_one2(sll_reach(*((old_curr_next->next))), old_curr_next))); 
                    assume $non_null($phys_ptr_cast(L#old_curr_next, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr_next, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr_next, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr_next, ^s_node));
                }
                else
                {
                  anon2:
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_keys(curr0), @_vcc_intset_union(sll_keys(*((curr0->next))), @_vcc_intset_singleton(*((curr0->key)))))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll(curr0), &&(sll(*((curr0->next))), unchecked!(@_vcc_oset_in(curr0, sll_reach(*((curr0->next)))))))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SL#curr0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(SL#curr0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_reach(curr0), @_vcc_oset_union_one2(sll_reach(*((curr0->next))), curr0))); 
                    assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $phys_ptr_cast(SL#curr0, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
                    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
                    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
                    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg(res, prv), &&(sll_lseg(*((res->next)), prv), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), prv)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node))));
                    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_reach(res, prv), @_vcc_oset_union_one2(sll_lseg_reach(*((res->next)), prv), res))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_keys(res, prv), @_vcc_intset_union(sll_lseg_keys(*((res->next)), prv), @_vcc_intset_singleton(*((res->key)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                    // struct s_node* old_curr1#0; 
                    // old_curr1#0 := old_curr; 
                    old_curr1#0 := $phys_ptr_cast(L#old_curr, ^s_node);
                    // struct s_node* stmtexpr0#7; 
                    // stmtexpr0#7 := old_curr1#0; 
                    stmtexpr0#7 := $phys_ptr_cast(old_curr1#0, ^s_node);
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                    // assert @reads_check_normal((old_curr->next)); 
                    assert $thread_local($s, $phys_ptr_cast(L#old_curr, ^s_node));
                    // res := *((old_curr->next)); 
                    L#res := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node);
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
                    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                    // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                    assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                }

              anon4:
                // _math \state _dryad_S0#1; 
                // _dryad_S0#1 := @_vcc_current_state(@state); 
                _dryad_S0#1 := $current_state($s);
                // _math \state stmtexpr0#8; 
                // stmtexpr0#8 := _dryad_S0#1; 
                stmtexpr0#8 := _dryad_S0#1;
                // void function
                // assert @writes_check(old_curr); 
                assert $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#old_curr, ^s_node));
                // assert @writes_check(@_vcc_extent(@state, old_curr)); 
                assert (forall #writes$2^37.7: $ptr :: { $dont_instantiate(#writes$2^37.7) } $set_in(#writes$2^37.7, $extent($s, $phys_ptr_cast(L#old_curr, ^s_node))) ==> $top_writable($s, #wrTime$2^3.3, #writes$2^37.7));
                // stmt _vcc_free(old_curr); 
                call $free($phys_ptr_cast(L#old_curr, ^s_node));
                assume $full_stop_ext(#tok$2^37.7, $s);
                // _math \state _dryad_S1#2; 
                // _dryad_S1#2 := @_vcc_current_state(@state); 
                _dryad_S1#2 := $current_state($s);
                // _math \state stmtexpr1#9; 
                // stmtexpr1#9 := _dryad_S1#2; 
                stmtexpr1#9 := _dryad_S1#2;
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(curr0)))), ==(old(_dryad_S0#1, sll_keys(curr0)), old(_dryad_S1#2, sll_keys(curr0)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(SL#curr0, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(SL#curr0, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(SL#curr0, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(curr0)))), ==(old(_dryad_S0#1, sll(curr0)), old(_dryad_S1#2, sll(curr0)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(SL#curr0, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(SL#curr0, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(SL#curr0, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(curr0)))), ==(old(_dryad_S0#1, sll_reach(curr0)), old(_dryad_S1#2, sll_reach(curr0)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(SL#curr0, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(SL#curr0, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(SL#curr0, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(prv)))), ==(old(_dryad_S0#1, sll_keys(prv)), old(_dryad_S1#2, sll_keys(prv)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(L#prv, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(prv)))), ==(old(_dryad_S0#1, sll(prv)), old(_dryad_S1#2, sll(prv)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(L#prv, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(prv)))), ==(old(_dryad_S0#1, sll_reach(prv)), old(_dryad_S1#2, sll_reach(prv)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#prv, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(curr)))), ==(old(_dryad_S0#1, sll_keys(curr)), old(_dryad_S1#2, sll_keys(curr)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(curr)))), ==(old(_dryad_S0#1, sll(curr)), old(_dryad_S1#2, sll(curr)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(curr)))), ==(old(_dryad_S0#1, sll_reach(curr)), old(_dryad_S1#2, sll_reach(curr)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#curr, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(res)))), ==(old(_dryad_S0#1, sll_keys(res)), old(_dryad_S1#2, sll_keys(res)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(res)))), ==(old(_dryad_S0#1, sll(res)), old(_dryad_S1#2, sll(res)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(res)))), ==(old(_dryad_S0#1, sll_reach(res)), old(_dryad_S1#2, sll_reach(res)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(x)))), ==(old(_dryad_S0#1, sll_keys(x)), old(_dryad_S1#2, sll_keys(x)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#x, ^s_node))) ==> F#sll_keys(_dryad_S0#1, $phys_ptr_cast(P#x, ^s_node)) == F#sll_keys(_dryad_S1#2, $phys_ptr_cast(P#x, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(x)))), ==(old(_dryad_S0#1, sll(x)), old(_dryad_S1#2, sll(x)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#x, ^s_node))) ==> F#sll(_dryad_S0#1, $phys_ptr_cast(P#x, ^s_node)) == F#sll(_dryad_S1#2, $phys_ptr_cast(P#x, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_reach(x)))), ==(old(_dryad_S0#1, sll_reach(x)), old(_dryad_S1#2, sll_reach(x)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#x, ^s_node))) ==> F#sll_reach(_dryad_S0#1, $phys_ptr_cast(P#x, ^s_node)) == F#sll_reach(_dryad_S1#2, $phys_ptr_cast(P#x, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_lseg_reach(res, prv)))), ==(old(_dryad_S0#1, sll_lseg(res, prv)), old(_dryad_S1#2, sll_lseg(res, prv)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_lseg(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == F#sll_lseg(_dryad_S1#2, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_lseg_reach(res, prv)))), ==(old(_dryad_S0#1, sll_lseg_reach(res, prv)), old(_dryad_S1#2, sll_lseg_reach(res, prv)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == F#sll_lseg_reach(_dryad_S1#2, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(unchecked!(@_vcc_oset_in(old_curr, old(_dryad_S0#1, sll_lseg_reach(res, prv)))), ==(old(_dryad_S0#1, sll_lseg_keys(res, prv)), old(_dryad_S1#2, sll_lseg_keys(res, prv)))); 
                assume !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_lseg_reach(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#1, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == F#sll_lseg_keys(_dryad_S1#2, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
            }
            else
            {
              anon5:
                // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_keys(curr0), @_vcc_intset_union(sll_keys(*((curr0->next))), @_vcc_intset_singleton(*((curr0->key)))))); 
                assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SL#curr0, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll(curr0), &&(sll(*((curr0->next))), unchecked!(@_vcc_oset_in(curr0, sll_reach(*((curr0->next)))))))); 
                assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll($s, $phys_ptr_cast(SL#curr0, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(SL#curr0, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr0), ==(sll_reach(curr0), @_vcc_oset_union_one2(sll_reach(*((curr0->next))), curr0))); 
                assume $non_null($phys_ptr_cast(SL#curr0, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(SL#curr0, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SL#curr0, ^s_node), ^s_node)), $phys_ptr_cast(SL#curr0, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_keys(old_curr), @_vcc_intset_union(sll_keys(*((old_curr->next))), @_vcc_intset_singleton(*((old_curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#old_curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll(old_curr), &&(sll(*((old_curr->next))), unchecked!(@_vcc_oset_in(old_curr, sll_reach(*((old_curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#old_curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#old_curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(old_curr), ==(sll_reach(old_curr), @_vcc_oset_union_one2(sll_reach(*((old_curr->next))), old_curr))); 
                assume $non_null($phys_ptr_cast(L#old_curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#old_curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#old_curr, ^s_node), ^s_node)), $phys_ptr_cast(L#old_curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
                assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
                assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
                assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
                assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
                assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
                assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
                assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg(res, prv), &&(sll_lseg(*((res->next)), prv), unchecked!(@_vcc_oset_in(res, sll_lseg_reach(*((res->next)), prv)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_reach(res, prv), @_vcc_oset_union_one2(sll_lseg_reach(*((res->next)), prv), res))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $phys_ptr_cast(L#res, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(res), @_vcc_ptr_neq_pure(res, prv)), ==(sll_lseg_keys(res, prv), @_vcc_intset_union(sll_lseg_keys(*((res->next)), prv), @_vcc_intset_singleton(*((res->key)))))); 
                assume $non_null($phys_ptr_cast(L#res, ^s_node)) && $phys_ptr_cast(L#res, ^s_node) != $phys_ptr_cast(L#prv, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node), $phys_ptr_cast(L#prv, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
                // prv := old_curr; 
                L#prv := $phys_ptr_cast(L#old_curr, ^s_node);
                // assert sll_lseg(curr0, curr0); 
                assert F#sll_lseg($s, $phys_ptr_cast(SL#curr0, ^s_node), $phys_ptr_cast(SL#curr0, ^s_node));
                // assume sll_lseg(curr0, curr0); 
                assume F#sll_lseg($s, $phys_ptr_cast(SL#curr0, ^s_node), $phys_ptr_cast(SL#curr0, ^s_node));
                // assert sll_lseg(old_curr, old_curr); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#old_curr, ^s_node), $phys_ptr_cast(L#old_curr, ^s_node));
                // assume sll_lseg(old_curr, old_curr); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#old_curr, ^s_node), $phys_ptr_cast(L#old_curr, ^s_node));
                // assert sll_lseg(prv, prv); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                // assume sll_lseg(prv, prv); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#prv, ^s_node), $phys_ptr_cast(L#prv, ^s_node));
                // assert sll_lseg(curr, curr); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
                // assume sll_lseg(curr, curr); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#curr, ^s_node), $phys_ptr_cast(L#curr, ^s_node));
                // assert sll_lseg(res, res); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assume sll_lseg(res, res); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#res, ^s_node), $phys_ptr_cast(L#res, ^s_node));
                // assert sll_lseg(x, x); 
                assert F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
                // assume sll_lseg(x, x); 
                assume F#sll_lseg($s, $phys_ptr_cast(P#x, ^s_node), $phys_ptr_cast(P#x, ^s_node));
            }
        }
        else
        {
          anon7:
            // assert @_vcc_possibly_unreachable; 
            assert {:PossiblyUnreachable true} true;
            // goto #break_2; 
            goto #break_2;
        }

      #continue_2:
        assume true;
    }

  anon10:
    assume $full_stop_ext(#tok$2^13.3, $s);

  #break_2:
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_keys(prv), @_vcc_intset_union(sll_keys(*((prv->next))), @_vcc_intset_singleton(*((prv->key)))))); 
    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#prv, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#prv, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll(prv), &&(sll(*((prv->next))), unchecked!(@_vcc_oset_in(prv, sll_reach(*((prv->next)))))))); 
    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#prv, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#prv, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(sll_reach(prv), @_vcc_oset_union_one2(sll_reach(*((prv->next))), prv))); 
    assume $non_null($phys_ptr_cast(L#prv, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#prv, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#prv, ^s_node), ^s_node)), $phys_ptr_cast(L#prv, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_keys(curr), @_vcc_intset_union(sll_keys(*((curr->next))), @_vcc_intset_singleton(*((curr->key)))))); 
    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#curr, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#curr, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll(curr), &&(sll(*((curr->next))), unchecked!(@_vcc_oset_in(curr, sll_reach(*((curr->next)))))))); 
    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#curr, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#curr, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(curr), ==(sll_reach(curr), @_vcc_oset_union_one2(sll_reach(*((curr->next))), curr))); 
    assume $non_null($phys_ptr_cast(L#curr, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#curr, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#curr, ^s_node), ^s_node)), $phys_ptr_cast(L#curr, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_keys(res), @_vcc_intset_union(sll_keys(*((res->next))), @_vcc_intset_singleton(*((res->key)))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#res, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#res, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll(res), &&(sll(*((res->next))), unchecked!(@_vcc_oset_in(res, sll_reach(*((res->next)))))))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#res, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#res, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(res), ==(sll_reach(res), @_vcc_oset_union_one2(sll_reach(*((res->next))), res))); 
    assume $non_null($phys_ptr_cast(L#res, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#res, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#res, ^s_node), ^s_node)), $phys_ptr_cast(L#res, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_keys(x), @_vcc_intset_union(sll_keys(*((x->next))), @_vcc_intset_singleton(*((x->key)))))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(P#x, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(P#x, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll(x), &&(sll(*((x->next))), unchecked!(@_vcc_oset_in(x, sll_reach(*((x->next)))))))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll($s, $phys_ptr_cast(P#x, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(P#x, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(x), ==(sll_reach(x), @_vcc_oset_union_one2(sll_reach(*((x->next))), x))); 
    assume $non_null($phys_ptr_cast(P#x, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(P#x, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(P#x, ^s_node), ^s_node)), $phys_ptr_cast(P#x, ^s_node));
    // return res; 
    $result := $phys_ptr_cast(L#res, ^s_node);
    assume true;
    assert $position_marker();
    goto #exit;

  anon11:
    // skip

  #exit:
}



const unique l#public: $label;

const unique #tok$2^37.7: $token;

const unique #tok$2^33.9: $token;

const unique #tok$2^13.3: $token;

const unique #tok$3^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(3, #file^?3Cno?20file?3E);

const unique #tok$2^3.3: $token;

const unique #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Csl?5Csl_filter.c: $token;

axiom $file_name_is(2, #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Csl?5Csl_filter.c);

const unique #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Csl?5Cdryad_sl.h: $token;

axiom $file_name_is(1, #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Csl?5Cdryad_sl.h);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^s_node);
