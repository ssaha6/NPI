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

const unique ^$#SLL_delete.c..36263#3: $ctype;

axiom $def_fnptr_type(^$#SLL_delete.c..36263#3);

type $#SLL_delete.c..36263#3;

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

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#sll_lseg(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg(#s, SP#hd, SP#tl)) && ($phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> F#sll_lseg(#s, SP#hd, SP#tl)) && ($is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> F#sll_lseg(#s, SP#hd, SP#tl) == F#sll(#s, $phys_ptr_cast(SP#hd, ^s_node))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && F#sll(#s, $phys_ptr_cast(SP#tl, ^s_node)) && $oset_disjoint(F#sll_reach(#s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> F#sll(#s, $phys_ptr_cast(SP#hd, ^s_node)) && F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_reach(#s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys(#s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_keys(#s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)))) && ($non_null($phys_ptr_cast(SP#hd, ^s_node)) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && F#sll(#s, $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && $oset_disjoint(F#sll_reach(#s, $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach(#s, $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> $oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach(#s, $phys_ptr_cast(SP#hd, ^s_node))) && F#sll_lseg(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union($intset_singleton($rd_inv(#s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))), F#sll_lseg_keys(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr(#s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union_one1($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)))));

axiom $function_arg_type(cf#sll_lseg, 0, ^^bool);

axiom $function_arg_type(cf#sll_lseg, 1, $ptr_to(^s_node));

axiom $function_arg_type(cf#sll_lseg, 2, $ptr_to(^s_node));

procedure sll_lseg(SP#hd: $ptr, SP#tl: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^s_node)) && $phys_ptr_cast(SP#hd, ^s_node) != $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $phys_ptr_cast(SP#hd, ^s_node) == $phys_ptr_cast(SP#tl, ^s_node) ==> $result;
  ensures $is_null($phys_ptr_cast(SP#tl, ^s_node)) ==> $result == F#sll($s, $phys_ptr_cast(SP#hd, ^s_node));
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && F#sll($s, $phys_ptr_cast(SP#tl, ^s_node)) && $oset_disjoint(F#sll_reach($s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> F#sll($s, $phys_ptr_cast(SP#hd, ^s_node)) && F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node)) == $oset_union(F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)), F#sll_reach($s, $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_keys($s, $phys_ptr_cast(SP#hd, ^s_node)) == $intset_union(F#sll_keys($s, $phys_ptr_cast(SP#tl, ^s_node)), F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)));
  ensures $non_null($phys_ptr_cast(SP#hd, ^s_node)) && $non_null($phys_ptr_cast(SP#tl, ^s_node)) && F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && $oset_disjoint(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) ==> $oset_in($phys_ptr_cast(SP#tl, ^s_node), F#sll_reach($s, $phys_ptr_cast(SP#hd, ^s_node))) && F#sll_lseg($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) && F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $intset_union($intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(SP#tl, ^s_node))), F#sll_lseg_keys($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node))) && F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(SP#tl, ^s_node), ^s_node)) == $oset_union_one1($phys_ptr_cast(SP#tl, ^s_node), F#sll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^s_node), $phys_ptr_cast(SP#tl, ^s_node)));
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



procedure delete(P#h: $ptr, P#k: int) returns ($result: $ptr);
  requires F#sll($s, $phys_ptr_cast(P#h, ^s_node));
  modifies $s, $cev_pc;
  ensures F#sll($s, $phys_ptr_cast($result, ^s_node));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation delete(P#h: $ptr, P#k: int) returns ($result: $ptr)
{
  var stmtexpr4#11: $state;
  var SL#_dryad_S3: $state;
  var stmtexpr3#10: $state;
  var SL#_dryad_S2: $state;
  var stmtexpr2#9: $state;
  var _dryad_S1#3: $state;
  var stmtexpr1#8: $state;
  var _dryad_S0#2: $state;
  var stmtexpr0#7: $ptr;
  var i0#1: $ptr;
  var stmtexpr2#6: $state;
  var SL#_dryad_S1: $state;
  var stmtexpr1#5: $state;
  var SL#_dryad_S0: $state;
  var stmtexpr0#4: $ptr;
  var i0#0: $ptr;
  var stmtexpr0#3: $ptr;
  var SL#i0: $ptr;
  var ite#1: bool;
  var loopState#0: $state;
  var L#i: $ptr;
  var L#j: $ptr;
  var L#t: $ptr;
  var stmtexpr1#13: $oset;
  var stmtexpr0#12: $oset;
  var SL#_dryad_G1: $oset;
  var SL#_dryad_G0: $oset;
  var local.h: $ptr;
  var #wrTime$2^3.3: int;
  var #stackframe: int;

  anon12:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^3.3, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$2^3.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^3.3, (lambda #p: $ptr :: false));
    // assume true
    // assume @in_range_i4(k); 
    assume $in_range_i4(P#k);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct s_node* local.h; 
    // local.h := h; 
    local.h := $phys_ptr_cast(P#h, ^s_node);
    //  --- Dryad annotated function --- 
    // _math \oset _dryad_G0; 
    // _math \oset _dryad_G1; 
    // _dryad_G0 := sll_reach(local.h); 
    call SL#_dryad_G0 := sll_reach($phys_ptr_cast(local.h, ^s_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _math \oset stmtexpr0#12; 
    // stmtexpr0#12 := _dryad_G0; 
    stmtexpr0#12 := SL#_dryad_G0;
    // _dryad_G1 := _dryad_G0; 
    SL#_dryad_G1 := SL#_dryad_G0;
    // _math \oset stmtexpr1#13; 
    // stmtexpr1#13 := _dryad_G1; 
    stmtexpr1#13 := SL#_dryad_G1;
    // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
    // struct s_node* t; 
    // struct s_node* j; 
    // struct s_node* i; 
    // assume ==>(@_vcc_ptr_neq_null(local.h), &&(@_vcc_mutable(@state, local.h), @writes_check(local.h))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> $mutable($s, $phys_ptr_cast(local.h, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.h, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(local.h), @_vcc_is_malloc_root(@state, local.h)); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> $is_malloc_root($s, $phys_ptr_cast(local.h, ^s_node));
    // i := local.h; 
    L#i := $phys_ptr_cast(local.h, ^s_node);
    // assert sll_lseg(i, i); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
    // assume sll_lseg(i, i); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
    // assert sll_lseg(j, j); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
    // assume sll_lseg(j, j); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
    // assert sll_lseg(t, t); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
    // assume sll_lseg(t, t); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
    // assert sll_lseg(local.h, local.h); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
    // assume sll_lseg(local.h, local.h); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
    // j := (struct s_node*)@null; 
    L#j := $phys_ptr_cast($null, ^s_node);
    // assert sll_lseg(i, i); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
    // assume sll_lseg(i, i); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
    // assert sll_lseg(j, j); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
    // assume sll_lseg(j, j); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
    // assert sll_lseg(t, t); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
    // assume sll_lseg(t, t); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
    // assert sll_lseg(local.h, local.h); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
    // assume sll_lseg(local.h, local.h); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
    assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
    assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
    assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
    // t := (struct s_node*)@null; 
    L#t := $phys_ptr_cast($null, ^s_node);
    // assert sll_lseg(i, i); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
    // assume sll_lseg(i, i); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
    // assert sll_lseg(j, j); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
    // assume sll_lseg(j, j); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
    // assert sll_lseg(t, t); 
    assert F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
    // assume sll_lseg(t, t); 
    assume F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
    // assert sll_lseg(local.h, local.h); 
    assert F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
    // assume sll_lseg(local.h, local.h); 
    assume F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
    assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
    assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
    assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
    assume true;
    // if (@_vcc_ptr_eq_null(i)) ...
    if ($is_null($phys_ptr_cast(L#i, ^s_node)))
    {
      anon1:
        // return local.h; 
        $result := $phys_ptr_cast(local.h, ^s_node);
        assume true;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon2:
        // assert @_vcc_possibly_unreachable; 
        assert {:PossiblyUnreachable true} true;
    }

  anon13:
    loopState#0 := $s;
    assume true;
    while (true)
      invariant F#sll($s, $phys_ptr_cast(local.h, ^s_node));
      invariant F#sll($s, $phys_ptr_cast(L#i, ^s_node));
      invariant F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
      invariant $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)), F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)));
      invariant F#sll($s, $phys_ptr_cast(L#t, ^s_node));
      invariant $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
      invariant $non_null($phys_ptr_cast(L#j, ^s_node)) ==> $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)), F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)));
      invariant $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
      invariant $non_null($phys_ptr_cast(L#t, ^s_node)) ==> $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)), F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)));
      invariant $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node));
      invariant $non_null($phys_ptr_cast(L#j, ^s_node)) ==> $oset_disjoint(F#sll_lseg_reach($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)), F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)));
      invariant $non_null($phys_ptr_cast(L#j, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node) == $phys_ptr_cast(L#i, ^s_node);
      invariant $non_null($phys_ptr_cast(L#i, ^s_node)) ==> $is_malloc_root($s, $phys_ptr_cast(L#i, ^s_node));
      invariant $non_null($phys_ptr_cast(L#i, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#i, ^s_node));
      invariant $non_null($phys_ptr_cast(L#i, ^s_node)) ==> $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#i, ^s_node));
    {
      anon7:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$2^16.3, $s);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        // _Bool ite#1; 
        // ite#1 := &&(@_vcc_ptr_neq_null(i), @_vcc_ptr_eq_null(t)); 
        ite#1 := $non_null($phys_ptr_cast(L#i, ^s_node)) && $is_null($phys_ptr_cast(L#t, ^s_node));
        assume true;
        // if (ite#1) ...
        if (ite#1)
        {
          anon5:
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg(j, t), &&(sll_lseg(*((j->next)), t), unchecked!(@_vcc_oset_in(j, sll_lseg_reach(*((j->next)), t)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_reach(j, t), @_vcc_oset_union_one2(sll_lseg_reach(*((j->next)), t), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_keys(j, t), @_vcc_intset_union(sll_lseg_keys(*((j->next)), t), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg(local.h, t), &&(sll_lseg(*((local.h->next)), t), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), t)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_reach(local.h, t), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), t), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_keys(local.h, t), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), t), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg(local.h, j), &&(sll_lseg(*((local.h->next)), j), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), j)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_reach(local.h, j), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), j), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_keys(local.h, j), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), j), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assert @reads_check_normal((i->key)); 
            assert $thread_local($s, $phys_ptr_cast(L#i, ^s_node));
            assume true;
            // if (==(*((i->key)), k)) ...
            if ($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node)) == P#k)
            {
              anon3:
                // t := i; 
                L#t := $phys_ptr_cast(L#i, ^s_node);
                // assert sll_lseg(i, i); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
                // assume sll_lseg(i, i); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
                // assert sll_lseg(j, j); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
                // assume sll_lseg(j, j); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
                // assert sll_lseg(t, t); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
                // assume sll_lseg(t, t); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
                // assert sll_lseg(local.h, local.h); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
                // assume sll_lseg(local.h, local.h); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
            }
            else
            {
              anon4:
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
                assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
                assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
                assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
                assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
                assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
                assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg(j, t), &&(sll_lseg(*((j->next)), t), unchecked!(@_vcc_oset_in(j, sll_lseg_reach(*((j->next)), t)))))); 
                assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_reach(j, t), @_vcc_oset_union_one2(sll_lseg_reach(*((j->next)), t), j))); 
                assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(L#j, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_keys(j, t), @_vcc_intset_union(sll_lseg_keys(*((j->next)), t), @_vcc_intset_singleton(*((j->key)))))); 
                assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg(local.h, t), &&(sll_lseg(*((local.h->next)), t), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), t)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_reach(local.h, t), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), t), local.h))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_keys(local.h, t), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), t), @_vcc_intset_singleton(*((local.h->key)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg(local.h, j), &&(sll_lseg(*((local.h->next)), j), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), j)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_reach(local.h, j), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), j), local.h))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_keys(local.h, j), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), j), @_vcc_intset_singleton(*((local.h->key)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
                // j := i; 
                L#j := $phys_ptr_cast(L#i, ^s_node);
                // assert sll_lseg(i, i); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
                // assume sll_lseg(i, i); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $phys_ptr_cast(L#i, ^s_node));
                // assert sll_lseg(j, j); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
                // assume sll_lseg(j, j); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#j, ^s_node));
                // assert sll_lseg(t, t); 
                assert F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
                // assume sll_lseg(t, t); 
                assume F#sll_lseg($s, $phys_ptr_cast(L#t, ^s_node), $phys_ptr_cast(L#t, ^s_node));
                // assert sll_lseg(local.h, local.h); 
                assert F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
                // assume sll_lseg(local.h, local.h); 
                assume F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(local.h, ^s_node));
                // struct s_node* i0; 
                // i0 := i; 
                SL#i0 := $phys_ptr_cast(L#i, ^s_node);
                // struct s_node* stmtexpr0#3; 
                // stmtexpr0#3 := i0; 
                stmtexpr0#3 := $phys_ptr_cast(SL#i0, ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(i), @_vcc_ptr_neq_pure(i, *((i->next)))), ==(sll_lseg(i, *((i->next))), &&(sll_lseg(*((i->next)), *((i->next))), unchecked!(@_vcc_oset_in(i, sll_lseg_reach(*((i->next)), *((i->next)))))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) && $phys_ptr_cast(L#i, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#i, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(i), @_vcc_ptr_neq_pure(i, *((i->next)))), ==(sll_lseg_reach(i, *((i->next))), @_vcc_oset_union_one2(sll_lseg_reach(*((i->next)), *((i->next))), i))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) && $phys_ptr_cast(L#i, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#i, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(i), @_vcc_ptr_neq_pure(i, *((i->next)))), ==(sll_lseg_keys(i, *((i->next))), @_vcc_intset_union(sll_lseg_keys(*((i->next)), *((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) && $phys_ptr_cast(L#i, ^s_node) != $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#i, ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node), $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
                // assert @reads_check_normal((i->next)); 
                assert $thread_local($s, $phys_ptr_cast(L#i, ^s_node));
                // i := *((i->next)); 
                L#i := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node);
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
                // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
                assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
                // assume ==>(@_vcc_ptr_neq_null(i), &&(@_vcc_mutable(@state, i), @writes_check(i))); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> $mutable($s, $phys_ptr_cast(L#i, ^s_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#i, ^s_node));
                // assume ==>(@_vcc_ptr_neq_null(i), @_vcc_is_malloc_root(@state, i)); 
                assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> $is_malloc_root($s, $phys_ptr_cast(L#i, ^s_node));
            }
        }
        else
        {
          anon6:
            // assert @_vcc_possibly_unreachable; 
            assert {:PossiblyUnreachable true} true;
            // goto #break_2; 
            goto #break_2;
        }

      #continue_2:
        assume true;
    }

  anon14:
    assume $full_stop_ext(#tok$2^16.3, $s);

  #break_2:
    // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
    assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
    assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
    assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
    assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
    assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
    assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
    assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
    assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
    assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
    // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
    assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
    assume true;
    // if (@_vcc_ptr_neq_null(i)) ...
    if ($non_null($phys_ptr_cast(L#i, ^s_node)))
    {
      anon10:
        assume true;
        // if (@_vcc_ptr_eq_null(j)) ...
        if ($is_null($phys_ptr_cast(L#j, ^s_node)))
        {
          anon8:
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg(j, t), &&(sll_lseg(*((j->next)), t), unchecked!(@_vcc_oset_in(j, sll_lseg_reach(*((j->next)), t)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_reach(j, t), @_vcc_oset_union_one2(sll_lseg_reach(*((j->next)), t), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_keys(j, t), @_vcc_intset_union(sll_lseg_keys(*((j->next)), t), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg(local.h, t), &&(sll_lseg(*((local.h->next)), t), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), t)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_reach(local.h, t), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), t), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_keys(local.h, t), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), t), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg(local.h, j), &&(sll_lseg(*((local.h->next)), j), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), j)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_reach(local.h, j), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), j), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_keys(local.h, j), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), j), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // struct s_node* i0#0; 
            // i0#0 := i; 
            i0#0 := $phys_ptr_cast(L#i, ^s_node);
            // struct s_node* stmtexpr0#4; 
            // stmtexpr0#4 := i0#0; 
            stmtexpr0#4 := $phys_ptr_cast(i0#0, ^s_node);
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // assert @reads_check_normal((i->next)); 
            assert $thread_local($s, $phys_ptr_cast(L#i, ^s_node));
            // local.h := *((i->next)); 
            local.h := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node);
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // _math \state _dryad_S0; 
            // _dryad_S0 := @_vcc_current_state(@state); 
            SL#_dryad_S0 := $current_state($s);
            // _math \state stmtexpr1#5; 
            // stmtexpr1#5 := _dryad_S0; 
            stmtexpr1#5 := SL#_dryad_S0;
            // void function
            // assert @writes_check(i); 
            assert $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#i, ^s_node));
            // assert @writes_check(@_vcc_extent(@state, i)); 
            assert (forall #writes$2^45.7: $ptr :: { $dont_instantiate(#writes$2^45.7) } $set_in(#writes$2^45.7, $extent($s, $phys_ptr_cast(L#i, ^s_node))) ==> $top_writable($s, #wrTime$2^3.3, #writes$2^45.7));
            // stmt _vcc_free(i); 
            call $free($phys_ptr_cast(L#i, ^s_node));
            assume $full_stop_ext(#tok$2^45.7, $s);
            // _math \state _dryad_S1; 
            // _dryad_S1 := @_vcc_current_state(@state); 
            SL#_dryad_S1 := $current_state($s);
            // _math \state stmtexpr2#6; 
            // stmtexpr2#6 := _dryad_S1; 
            stmtexpr2#6 := SL#_dryad_S1;
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(i0#0)))), ==(old(_dryad_S0, sll_keys(i0#0)), old(_dryad_S1, sll_keys(i0#0)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(i0#0, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(i0#0, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(i0#0, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(i0#0)))), ==(old(_dryad_S0, sll(i0#0)), old(_dryad_S1, sll(i0#0)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(i0#0, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(i0#0, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(i0#0, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(i0#0)))), ==(old(_dryad_S0, sll_reach(i0#0)), old(_dryad_S1, sll_reach(i0#0)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(i0#0, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(i0#0, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(i0#0, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(j)))), ==(old(_dryad_S0, sll_keys(j)), old(_dryad_S1, sll_keys(j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(j)))), ==(old(_dryad_S0, sll(j)), old(_dryad_S1, sll(j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(j)))), ==(old(_dryad_S0, sll_reach(j)), old(_dryad_S1, sll_reach(j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(t)))), ==(old(_dryad_S0, sll_keys(t)), old(_dryad_S1, sll_keys(t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(L#t, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(t)))), ==(old(_dryad_S0, sll(t)), old(_dryad_S1, sll(t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(L#t, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(t)))), ==(old(_dryad_S0, sll_reach(t)), old(_dryad_S1, sll_reach(t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(L#t, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(local.h)))), ==(old(_dryad_S0, sll_keys(local.h)), old(_dryad_S1, sll_keys(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node)) == F#sll_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(local.h)))), ==(old(_dryad_S0, sll(local.h)), old(_dryad_S1, sll(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node)) == F#sll(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_reach(local.h)))), ==(old(_dryad_S0, sll_reach(local.h)), old(_dryad_S1, sll_reach(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node)) == F#sll_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(j, t)))), ==(old(_dryad_S0, sll_lseg(j, t)), old(_dryad_S1, sll_lseg(j, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(j, t)))), ==(old(_dryad_S0, sll_lseg_reach(j, t)), old(_dryad_S1, sll_lseg_reach(j, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(j, t)))), ==(old(_dryad_S0, sll_lseg_keys(j, t)), old(_dryad_S1, sll_lseg_keys(j, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, t)))), ==(old(_dryad_S0, sll_lseg(local.h, t)), old(_dryad_S1, sll_lseg(local.h, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, t)))), ==(old(_dryad_S0, sll_lseg_reach(local.h, t)), old(_dryad_S1, sll_lseg_reach(local.h, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, t)))), ==(old(_dryad_S0, sll_lseg_keys(local.h, t)), old(_dryad_S1, sll_lseg_keys(local.h, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0, sll_lseg(local.h, j)), old(_dryad_S1, sll_lseg(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0, sll_lseg_reach(local.h, j)), old(_dryad_S1, sll_lseg_reach(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0, sll_lseg_keys(local.h, j)), old(_dryad_S1, sll_lseg_keys(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0, sll_lseg(local.h, i)), old(_dryad_S1, sll_lseg(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0, sll_lseg_reach(local.h, i)), old(_dryad_S1, sll_lseg_reach(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0, sll_lseg_keys(local.h, i)), old(_dryad_S1, sll_lseg_keys(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, t)))), ==(old(_dryad_S0, sll_lseg(local.h, t)), old(_dryad_S1, sll_lseg(local.h, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, t)))), ==(old(_dryad_S0, sll_lseg_reach(local.h, t)), old(_dryad_S1, sll_lseg_reach(local.h, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, t)))), ==(old(_dryad_S0, sll_lseg_keys(local.h, t)), old(_dryad_S1, sll_lseg_keys(local.h, t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0, sll_lseg(local.h, j)), old(_dryad_S1, sll_lseg(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0, sll_lseg_reach(local.h, j)), old(_dryad_S1, sll_lseg_reach(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0, sll_lseg_keys(local.h, j)), old(_dryad_S1, sll_lseg_keys(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0, sll_lseg(local.h, i)), old(_dryad_S1, sll_lseg(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0, sll_lseg_reach(local.h, i)), old(_dryad_S1, sll_lseg_reach(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0, sll_lseg_keys(local.h, i)), old(_dryad_S1, sll_lseg_keys(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S0, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S1, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
        }
        else
        {
          anon9:
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg(j, t), &&(sll_lseg(*((j->next)), t), unchecked!(@_vcc_oset_in(j, sll_lseg_reach(*((j->next)), t)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_reach(j, t), @_vcc_oset_union_one2(sll_lseg_reach(*((j->next)), t), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(j), @_vcc_ptr_neq_pure(j, t)), ==(sll_lseg_keys(j, t), @_vcc_intset_union(sll_lseg_keys(*((j->next)), t), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) && $phys_ptr_cast(L#j, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(L#j, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg(local.h, t), &&(sll_lseg(*((local.h->next)), t), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), t)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_reach(local.h, t), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), t), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, t)), ==(sll_lseg_keys(local.h, t), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), t), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#t, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#t, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg(local.h, j), &&(sll_lseg(*((local.h->next)), j), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), j)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_reach(local.h, j), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), j), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, j)), ==(sll_lseg_keys(local.h, j), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), j), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#j, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#j, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // struct s_node* i0#1; 
            // i0#1 := i; 
            i0#1 := $phys_ptr_cast(L#i, ^s_node);
            // struct s_node* stmtexpr0#7; 
            // stmtexpr0#7 := i0#1; 
            stmtexpr0#7 := $phys_ptr_cast(i0#1, ^s_node);
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // assert @reads_check_normal((i->next)); 
            assert $thread_local($s, $phys_ptr_cast(L#i, ^s_node));
            // t := *((i->next)); 
            L#t := $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node);
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // _math \state _dryad_S0#2; 
            // _dryad_S0#2 := @_vcc_current_state(@state); 
            _dryad_S0#2 := $current_state($s);
            // _math \state stmtexpr1#8; 
            // stmtexpr1#8 := _dryad_S0#2; 
            stmtexpr1#8 := _dryad_S0#2;
            // void function
            // assert @writes_check(i); 
            assert $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#i, ^s_node));
            // assert @writes_check(@_vcc_extent(@state, i)); 
            assert (forall #writes$2^48.7: $ptr :: { $dont_instantiate(#writes$2^48.7) } $set_in(#writes$2^48.7, $extent($s, $phys_ptr_cast(L#i, ^s_node))) ==> $top_writable($s, #wrTime$2^3.3, #writes$2^48.7));
            // stmt _vcc_free(i); 
            call $free($phys_ptr_cast(L#i, ^s_node));
            assume $full_stop_ext(#tok$2^48.7, $s);
            // _math \state _dryad_S1#3; 
            // _dryad_S1#3 := @_vcc_current_state(@state); 
            _dryad_S1#3 := $current_state($s);
            // _math \state stmtexpr2#9; 
            // stmtexpr2#9 := _dryad_S1#3; 
            stmtexpr2#9 := _dryad_S1#3;
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(i0#1)))), ==(old(_dryad_S0#2, sll_keys(i0#1)), old(_dryad_S1#3, sll_keys(i0#1)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(i0#1, ^s_node))) ==> F#sll_keys(_dryad_S0#2, $phys_ptr_cast(i0#1, ^s_node)) == F#sll_keys(_dryad_S1#3, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(i0#1)))), ==(old(_dryad_S0#2, sll(i0#1)), old(_dryad_S1#3, sll(i0#1)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(i0#1, ^s_node))) ==> F#sll(_dryad_S0#2, $phys_ptr_cast(i0#1, ^s_node)) == F#sll(_dryad_S1#3, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(i0#1)))), ==(old(_dryad_S0#2, sll_reach(i0#1)), old(_dryad_S1#3, sll_reach(i0#1)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(i0#1, ^s_node))) ==> F#sll_reach(_dryad_S0#2, $phys_ptr_cast(i0#1, ^s_node)) == F#sll_reach(_dryad_S1#3, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(j)))), ==(old(_dryad_S0#2, sll_keys(j)), old(_dryad_S1#3, sll_keys(j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_keys(_dryad_S0#2, $phys_ptr_cast(L#j, ^s_node)) == F#sll_keys(_dryad_S1#3, $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(j)))), ==(old(_dryad_S0#2, sll(j)), old(_dryad_S1#3, sll(j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#j, ^s_node))) ==> F#sll(_dryad_S0#2, $phys_ptr_cast(L#j, ^s_node)) == F#sll(_dryad_S1#3, $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(j)))), ==(old(_dryad_S0#2, sll_reach(j)), old(_dryad_S1#3, sll_reach(j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#j, ^s_node)) == F#sll_reach(_dryad_S1#3, $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(t)))), ==(old(_dryad_S0#2, sll_keys(t)), old(_dryad_S1#3, sll_keys(t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_keys(_dryad_S0#2, $phys_ptr_cast(L#t, ^s_node)) == F#sll_keys(_dryad_S1#3, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(t)))), ==(old(_dryad_S0#2, sll(t)), old(_dryad_S1#3, sll(t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll(_dryad_S0#2, $phys_ptr_cast(L#t, ^s_node)) == F#sll(_dryad_S1#3, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(t)))), ==(old(_dryad_S0#2, sll_reach(t)), old(_dryad_S1#3, sll_reach(t)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_reach(_dryad_S0#2, $phys_ptr_cast(L#t, ^s_node)) == F#sll_reach(_dryad_S1#3, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(local.h)))), ==(old(_dryad_S0#2, sll_keys(local.h)), old(_dryad_S1#3, sll_keys(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll_keys(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node)) == F#sll_keys(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(local.h)))), ==(old(_dryad_S0#2, sll(local.h)), old(_dryad_S1#3, sll(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node)) == F#sll(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_reach(local.h)))), ==(old(_dryad_S0#2, sll_reach(local.h)), old(_dryad_S1#3, sll_reach(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node)) == F#sll_reach(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0#2, sll_lseg(local.h, j)), old(_dryad_S1#3, sll_lseg(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0#2, sll_lseg_reach(local.h, j)), old(_dryad_S1#3, sll_lseg_reach(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_reach(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S0#2, sll_lseg_keys(local.h, j)), old(_dryad_S1#3, sll_lseg_keys(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_keys(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0#2, sll_lseg(local.h, i)), old(_dryad_S1#3, sll_lseg(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0#2, sll_lseg_reach(local.h, i)), old(_dryad_S1#3, sll_lseg_reach(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_reach(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0#2, sll_lseg_keys(local.h, i)), old(_dryad_S1#3, sll_lseg_keys(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_keys(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0#2, sll_lseg(local.h, i)), old(_dryad_S1#3, sll_lseg(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0#2, sll_lseg_reach(local.h, i)), old(_dryad_S1#3, sll_lseg_reach(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_reach(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(i, old(_dryad_S0#2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S0#2, sll_lseg_keys(local.h, i)), old(_dryad_S1#3, sll_lseg_keys(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_lseg_reach(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_keys(_dryad_S0#2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_keys(_dryad_S1#3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // _math \state _dryad_S2; 
            // _dryad_S2 := @_vcc_current_state(@state); 
            SL#_dryad_S2 := $current_state($s);
            // _math \state stmtexpr3#10; 
            // stmtexpr3#10 := _dryad_S2; 
            stmtexpr3#10 := SL#_dryad_S2;
            // assert @prim_writes_check((j->next)); 
            assert $writable_prim($s, #wrTime$2^3.3, $dot($phys_ptr_cast(L#j, ^s_node), s_node.next));
            // *(j->next) := t; 
            call $write_int(s_node.next, $phys_ptr_cast(L#j, ^s_node), $ptr_to_int($phys_ptr_cast(L#t, ^s_node)));
            assume $full_stop_ext(#tok$2^49.7, $s);
            // _math \state _dryad_S3; 
            // _dryad_S3 := @_vcc_current_state(@state); 
            SL#_dryad_S3 := $current_state($s);
            // _math \state stmtexpr4#11; 
            // stmtexpr4#11 := _dryad_S3; 
            stmtexpr4#11 := SL#_dryad_S3;
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(i0#1)))), ==(old(_dryad_S2, sll_keys(i0#1)), old(_dryad_S3, sll_keys(i0#1)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(i0#1, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(i0#1, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(i0#1)))), ==(old(_dryad_S2, sll(i0#1)), old(_dryad_S3, sll(i0#1)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(i0#1, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(i0#1, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(i0#1)))), ==(old(_dryad_S2, sll_reach(i0#1)), old(_dryad_S3, sll_reach(i0#1)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(i0#1, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(i0#1, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(i)))), ==(old(_dryad_S2, sll_keys(i)), old(_dryad_S3, sll_keys(i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(L#i, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(i)))), ==(old(_dryad_S2, sll(i)), old(_dryad_S3, sll(i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#i, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(L#i, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(i)))), ==(old(_dryad_S2, sll_reach(i)), old(_dryad_S3, sll_reach(i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#i, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(t)))), ==(old(_dryad_S2, sll_keys(t)), old(_dryad_S3, sll_keys(t)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(L#t, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(t)))), ==(old(_dryad_S2, sll(t)), old(_dryad_S3, sll(t)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(L#t, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(t)))), ==(old(_dryad_S2, sll_reach(t)), old(_dryad_S3, sll_reach(t)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#t, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(L#t, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(local.h)))), ==(old(_dryad_S2, sll_keys(local.h)), old(_dryad_S3, sll_keys(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll_keys(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node)) == F#sll_keys(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(local.h)))), ==(old(_dryad_S2, sll(local.h)), old(_dryad_S3, sll(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node)) == F#sll(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_reach(local.h)))), ==(old(_dryad_S2, sll_reach(local.h)), old(_dryad_S3, sll_reach(local.h)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node))) ==> F#sll_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node)) == F#sll_reach(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S2, sll_lseg(local.h, j)), old(_dryad_S3, sll_lseg(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S2, sll_lseg_reach(local.h, j)), old(_dryad_S3, sll_lseg_reach(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, j)))), ==(old(_dryad_S2, sll_lseg_keys(local.h, j)), old(_dryad_S3, sll_lseg_keys(local.h, j)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S2, sll_lseg(local.h, i)), old(_dryad_S3, sll_lseg(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S2, sll_lseg_reach(local.h, i)), old(_dryad_S3, sll_lseg_reach(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S2, sll_lseg_keys(local.h, i)), old(_dryad_S3, sll_lseg_keys(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S2, sll_lseg(local.h, i)), old(_dryad_S3, sll_lseg(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S2, sll_lseg_reach(local.h, i)), old(_dryad_S3, sll_lseg_reach(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_reach(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(unchecked!(@_vcc_oset_in(j, old(_dryad_S2, sll_lseg_reach(local.h, i)))), ==(old(_dryad_S2, sll_lseg_keys(local.h, i)), old(_dryad_S3, sll_lseg_keys(local.h, i)))); 
            assume !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_lseg_reach(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node))) ==> F#sll_lseg_keys(SL#_dryad_S2, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == F#sll_lseg_keys(SL#_dryad_S3, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(!(@_vcc_ptr_eq_pure(j, i0#1)), ==(*((i0#1->key)), old(_dryad_S2, *((i0#1->key))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(i0#1, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(i0#1, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(!(@_vcc_ptr_eq_pure(j, i0#1)), @_vcc_ptr_eq_pure(*((i0#1->next)), old(_dryad_S2, *((i0#1->next))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(i0#1, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(i0#1, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(i0#1, ^s_node), ^s_node);
            // assume ==>(!(@_vcc_ptr_eq_pure(j, i)), ==(*((i->key)), old(_dryad_S2, *((i->key))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(L#i, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(!(@_vcc_ptr_eq_pure(j, i)), @_vcc_ptr_eq_pure(*((i->next)), old(_dryad_S2, *((i->next))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(L#i, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node);
            // assume ==>(!(@_vcc_ptr_eq_pure(j, t)), ==(*((t->key)), old(_dryad_S2, *((t->key))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(L#t, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(!(@_vcc_ptr_eq_pure(j, t)), @_vcc_ptr_eq_pure(*((t->next)), old(_dryad_S2, *((t->next))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(L#t, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node);
            // assume ==>(!(@_vcc_ptr_eq_pure(j, local.h)), ==(*((local.h->key)), old(_dryad_S2, *((local.h->key))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(local.h, ^s_node)) ==> $rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node)) == $rd_inv(SL#_dryad_S2, s_node.key, $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(!(@_vcc_ptr_eq_pure(j, local.h)), @_vcc_ptr_eq_pure(*((local.h->next)), old(_dryad_S2, *((local.h->next))))); 
            assume !($phys_ptr_cast(L#j, ^s_node) == $phys_ptr_cast(local.h, ^s_node)) ==> $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node) == $rd_phys_ptr(SL#_dryad_S2, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node);
            // assume ==>(@_vcc_ptr_neq_null(i0#1), ==(sll_keys(i0#1), @_vcc_intset_union(sll_keys(*((i0#1->next))), @_vcc_intset_singleton(*((i0#1->key)))))); 
            assume $non_null($phys_ptr_cast(i0#1, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(i0#1, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(i0#1, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(i0#1, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i0#1), ==(sll(i0#1), &&(sll(*((i0#1->next))), unchecked!(@_vcc_oset_in(i0#1, sll_reach(*((i0#1->next)))))))); 
            assume $non_null($phys_ptr_cast(i0#1, ^s_node)) ==> F#sll($s, $phys_ptr_cast(i0#1, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(i0#1, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(i0#1, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(i0#1, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i0#1), ==(sll_reach(i0#1), @_vcc_oset_union_one2(sll_reach(*((i0#1->next))), i0#1))); 
            assume $non_null($phys_ptr_cast(i0#1, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(i0#1, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(i0#1, ^s_node), ^s_node)), $phys_ptr_cast(i0#1, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_keys(i), @_vcc_intset_union(sll_keys(*((i->next))), @_vcc_intset_singleton(*((i->key)))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll(i), &&(sll(*((i->next))), unchecked!(@_vcc_oset_in(i, sll_reach(*((i->next)))))))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#i, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#i, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(i), ==(sll_reach(i), @_vcc_oset_union_one2(sll_reach(*((i->next))), i))); 
            assume $non_null($phys_ptr_cast(L#i, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#i, ^s_node), ^s_node)), $phys_ptr_cast(L#i, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_keys(local.h), @_vcc_intset_union(sll_keys(*((local.h->next))), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(local.h, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll(local.h), &&(sll(*((local.h->next))), unchecked!(@_vcc_oset_in(local.h, sll_reach(*((local.h->next)))))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll($s, $phys_ptr_cast(local.h, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.h), ==(sll_reach(local.h), @_vcc_oset_union_one2(sll_reach(*((local.h->next))), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(local.h, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_keys(j), @_vcc_intset_union(sll_keys(*((j->next))), @_vcc_intset_singleton(*((j->key)))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#j, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#j, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll(j), &&(sll(*((j->next))), unchecked!(@_vcc_oset_in(j, sll_reach(*((j->next)))))))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#j, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#j, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(j), ==(sll_reach(j), @_vcc_oset_union_one2(sll_reach(*((j->next))), j))); 
            assume $non_null($phys_ptr_cast(L#j, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#j, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#j, ^s_node), ^s_node)), $phys_ptr_cast(L#j, ^s_node));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_keys(t), @_vcc_intset_union(sll_keys(*((t->next))), @_vcc_intset_singleton(*((t->key)))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_keys($s, $phys_ptr_cast(L#t, ^s_node)) == $intset_union(F#sll_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(L#t, ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll(t), &&(sll(*((t->next))), unchecked!(@_vcc_oset_in(t, sll_reach(*((t->next)))))))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll($s, $phys_ptr_cast(L#t, ^s_node)) == (F#sll($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)) && !$oset_in($phys_ptr_cast(L#t, ^s_node), F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node))));
            // assume ==>(@_vcc_ptr_neq_null(t), ==(sll_reach(t), @_vcc_oset_union_one2(sll_reach(*((t->next))), t))); 
            assume $non_null($phys_ptr_cast(L#t, ^s_node)) ==> F#sll_reach($s, $phys_ptr_cast(L#t, ^s_node)) == $oset_union_one2(F#sll_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(L#t, ^s_node), ^s_node)), $phys_ptr_cast(L#t, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg(local.h, i), &&(sll_lseg(*((local.h->next)), i), unchecked!(@_vcc_oset_in(local.h, sll_lseg_reach(*((local.h->next)), i)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == (F#sll_lseg($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)) && !$oset_in($phys_ptr_cast(local.h, ^s_node), F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node))));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_reach(local.h, i), @_vcc_oset_union_one2(sll_lseg_reach(*((local.h->next)), i), local.h))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_reach($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $oset_union_one2(F#sll_lseg_reach($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $phys_ptr_cast(local.h, ^s_node));
            // assume ==>(&&(@_vcc_ptr_neq_null(local.h), @_vcc_ptr_neq_pure(local.h, i)), ==(sll_lseg_keys(local.h, i), @_vcc_intset_union(sll_lseg_keys(*((local.h->next)), i), @_vcc_intset_singleton(*((local.h->key)))))); 
            assume $non_null($phys_ptr_cast(local.h, ^s_node)) && $phys_ptr_cast(local.h, ^s_node) != $phys_ptr_cast(L#i, ^s_node) ==> F#sll_lseg_keys($s, $phys_ptr_cast(local.h, ^s_node), $phys_ptr_cast(L#i, ^s_node)) == $intset_union(F#sll_lseg_keys($s, $rd_phys_ptr($s, s_node.next, $phys_ptr_cast(local.h, ^s_node), ^s_node), $phys_ptr_cast(L#i, ^s_node)), $intset_singleton($rd_inv($s, s_node.key, $phys_ptr_cast(local.h, ^s_node))));
        }
    }
    else
    {
      anon11:
        // assert @_vcc_possibly_unreachable; 
        assert {:PossiblyUnreachable true} true;
    }

  anon15:
    // return local.h; 
    $result := $phys_ptr_cast(local.h, ^s_node);
    assume true;
    assert $position_marker();
    goto #exit;

  anon16:
    // skip

  #exit:
}



const unique l#public: $label;

const unique #tok$2^49.7: $token;

const unique #tok$2^48.7: $token;

const unique #tok$2^45.7: $token;

const unique #tok$2^16.3: $token;

const unique #tok$3^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(3, #file^?3Cno?20file?3E);

const unique #tok$2^3.3: $token;

const unique #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cafwp?5CSLL?2Ddelete.c: $token;

axiom $file_name_is(2, #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cafwp?5CSLL?2Ddelete.c);

const unique #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cafwp?5Cdryad_SLL.h: $token;

axiom $file_name_is(1, #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cafwp?5Cdryad_SLL.h);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^s_node);
