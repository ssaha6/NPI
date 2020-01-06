axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$##thread_id: $ctype;

axiom $def_math_type(^$##thread_id);

type $##thread_id;

const unique ^$##club: $ctype;

axiom $def_math_type(^$##club);

type $##club;

const unique ^d_node: $ctype;

axiom $is_span_sequential(^d_node);

axiom $def_struct_type(^d_node, 16, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^d_node) } $inv2(#s1, #s2, #p, ^d_node) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2_without_lemmas(#s1, #s2, #p, ^d_node) } $inv2_without_lemmas(#s1, #s2, #p, ^d_node) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^d_node)) } $in(q, $composite_extent(s, p, ^d_node)) == (q == p));

const unique d_node.prev: $field;

axiom $def_phys_field(^d_node, d_node.prev, $ptr_to(^d_node), false, 0);

const unique d_node.next: $field;

axiom $def_phys_field(^d_node, d_node.next, $ptr_to(^d_node), false, 8);

const unique ^$#_purecall_handler#1: $ctype;

axiom $def_fnptr_type(^$#_purecall_handler#1);

type $#_purecall_handler#1;

const unique ^$#_invalid_parameter_handler#2: $ctype;

axiom $def_fnptr_type(^$#_invalid_parameter_handler#2);

type $#_invalid_parameter_handler#2;

const unique ^$#dl_dispose.c..36263#3: $ctype;

axiom $def_fnptr_type(^$#dl_dispose.c..36263#3);

type $#dl_dispose.c..36263#3;

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

function F#dll(#s: $state, SP#hd: $ptr) : bool;

const unique cf#dll: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#dll(#s, SP#hd) } 1 < $decreases_level ==> $is_null($phys_ptr_cast(SP#hd, ^d_node)) ==> F#dll(#s, SP#hd));

axiom $function_arg_type(cf#dll, 0, ^^bool);

axiom $function_arg_type(cf#dll, 1, $ptr_to(^d_node));

procedure dll(SP#hd: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^d_node)) ==> $result;
  free ensures $result == F#dll($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#dll_reach(#s: $state, SP#hd: $ptr) : $oset;

const unique cf#dll_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr :: { F#dll_reach(#s, SP#hd) } 1 < $decreases_level ==> ($non_null($phys_ptr_cast(SP#hd, ^d_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^d_node), F#dll_reach(#s, SP#hd))) && ($is_null($phys_ptr_cast(SP#hd, ^d_node)) ==> F#dll_reach(#s, SP#hd) == $oset_empty()));

axiom $function_arg_type(cf#dll_reach, 0, ^$#oset);

axiom $function_arg_type(cf#dll_reach, 1, $ptr_to(^d_node));

procedure dll_reach(SP#hd: $ptr) returns ($result: $oset);
  ensures ($non_null($phys_ptr_cast(SP#hd, ^d_node)) ==> $oset_in($phys_ptr_cast(SP#hd, ^d_node), $result)) && ($is_null($phys_ptr_cast(SP#hd, ^d_node)) ==> $result == $oset_empty());
  free ensures $result == F#dll_reach($s, SP#hd);
  free ensures $call_transition(old($s), $s);



function F#dll_lseg(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : bool;

const unique cf#dll_lseg: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#dll_lseg(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($is_null($phys_ptr_cast(SP#hd, ^d_node)) && $phys_ptr_cast(SP#hd, ^d_node) != $phys_ptr_cast(SP#tl, ^d_node) ==> F#dll_lseg(#s, SP#hd, SP#tl)) && ($phys_ptr_cast(SP#hd, ^d_node) == $phys_ptr_cast(SP#tl, ^d_node) ==> F#dll_lseg(#s, SP#hd, SP#tl)) && ($is_null($phys_ptr_cast(SP#tl, ^d_node)) ==> F#dll_lseg(#s, SP#hd, SP#tl) == F#dll(#s, $phys_ptr_cast(SP#hd, ^d_node))) && ($non_null($phys_ptr_cast(SP#hd, ^d_node)) && F#dll(#s, $phys_ptr_cast(SP#tl, ^d_node)) && $oset_disjoint(F#dll_reach(#s, $phys_ptr_cast(SP#tl, ^d_node)), F#dll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node))) ==> F#dll(#s, $phys_ptr_cast(SP#hd, ^d_node)) && F#dll_reach(#s, $phys_ptr_cast(SP#hd, ^d_node)) == $oset_union(F#dll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node)), F#dll_reach(#s, $phys_ptr_cast(SP#tl, ^d_node)))) && ($non_null($phys_ptr_cast(SP#hd, ^d_node)) && $non_null($phys_ptr_cast(SP#tl, ^d_node)) && F#dll(#s, $rd_phys_ptr(#s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)) && F#dll_lseg(#s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node)) && $oset_disjoint(F#dll_reach(#s, $rd_phys_ptr(#s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)), F#dll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^d_node), F#dll_reach(#s, $rd_phys_ptr(#s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^d_node), F#dll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node))) ==> $oset_in($phys_ptr_cast(SP#tl, ^d_node), F#dll_reach(#s, $phys_ptr_cast(SP#hd, ^d_node))) && F#dll_lseg(#s, $phys_ptr_cast(SP#hd, ^d_node), $rd_phys_ptr(#s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)) && F#dll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^d_node), $rd_phys_ptr(#s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)) == $oset_union($oset_singleton($phys_ptr_cast(SP#tl, ^d_node)), F#dll_lseg_reach(#s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node)))));

axiom $function_arg_type(cf#dll_lseg, 0, ^^bool);

axiom $function_arg_type(cf#dll_lseg, 1, $ptr_to(^d_node));

axiom $function_arg_type(cf#dll_lseg, 2, $ptr_to(^d_node));

procedure dll_lseg(SP#hd: $ptr, SP#tl: $ptr) returns ($result: bool);
  ensures $is_null($phys_ptr_cast(SP#hd, ^d_node)) && $phys_ptr_cast(SP#hd, ^d_node) != $phys_ptr_cast(SP#tl, ^d_node) ==> $result;
  ensures $phys_ptr_cast(SP#hd, ^d_node) == $phys_ptr_cast(SP#tl, ^d_node) ==> $result;
  ensures $is_null($phys_ptr_cast(SP#tl, ^d_node)) ==> $result == F#dll($s, $phys_ptr_cast(SP#hd, ^d_node));
  ensures $non_null($phys_ptr_cast(SP#hd, ^d_node)) && F#dll($s, $phys_ptr_cast(SP#tl, ^d_node)) && $oset_disjoint(F#dll_reach($s, $phys_ptr_cast(SP#tl, ^d_node)), F#dll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node))) ==> F#dll($s, $phys_ptr_cast(SP#hd, ^d_node)) && F#dll_reach($s, $phys_ptr_cast(SP#hd, ^d_node)) == $oset_union(F#dll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node)), F#dll_reach($s, $phys_ptr_cast(SP#tl, ^d_node)));
  ensures $non_null($phys_ptr_cast(SP#hd, ^d_node)) && $non_null($phys_ptr_cast(SP#tl, ^d_node)) && F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)) && F#dll_lseg($s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node)) && $oset_disjoint(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)), F#dll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node))) && !$oset_in($phys_ptr_cast(SP#tl, ^d_node), F#dll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node))) ==> $oset_in($phys_ptr_cast(SP#tl, ^d_node), F#dll_reach($s, $phys_ptr_cast(SP#hd, ^d_node))) && F#dll_lseg($s, $phys_ptr_cast(SP#hd, ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)) && F#dll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(SP#tl, ^d_node), ^d_node)) == $oset_union($oset_singleton($phys_ptr_cast(SP#tl, ^d_node)), F#dll_lseg_reach($s, $phys_ptr_cast(SP#hd, ^d_node), $phys_ptr_cast(SP#tl, ^d_node)));
  free ensures $result == F#dll_lseg($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



function F#dll_lseg_reach(#s: $state, SP#hd: $ptr, SP#tl: $ptr) : $oset;

const unique cf#dll_lseg_reach: $pure_function;

axiom (forall #s: $state, SP#hd: $ptr, SP#tl: $ptr :: { F#dll_lseg_reach(#s, SP#hd, SP#tl) } 1 < $decreases_level ==> ($phys_ptr_cast(SP#hd, ^d_node) == $phys_ptr_cast(SP#tl, ^d_node) ==> F#dll_lseg_reach(#s, SP#hd, SP#tl) == $oset_empty()) && ($is_null($phys_ptr_cast(SP#hd, ^d_node)) && $phys_ptr_cast(SP#hd, ^d_node) != $phys_ptr_cast(SP#tl, ^d_node) ==> F#dll_lseg_reach(#s, SP#hd, SP#tl) == $oset_empty()) && ($non_null($phys_ptr_cast(SP#hd, ^d_node)) && $phys_ptr_cast(SP#hd, ^d_node) != $phys_ptr_cast(SP#tl, ^d_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^d_node), F#dll_lseg_reach(#s, SP#hd, SP#tl))) && ($non_null($phys_ptr_cast(SP#hd, ^d_node)) && $is_null($phys_ptr_cast(SP#tl, ^d_node)) ==> F#dll_lseg_reach(#s, SP#hd, SP#tl) == F#dll_reach(#s, $phys_ptr_cast(SP#hd, ^d_node))));

axiom $function_arg_type(cf#dll_lseg_reach, 0, ^$#oset);

axiom $function_arg_type(cf#dll_lseg_reach, 1, $ptr_to(^d_node));

axiom $function_arg_type(cf#dll_lseg_reach, 2, $ptr_to(^d_node));

procedure dll_lseg_reach(SP#hd: $ptr, SP#tl: $ptr) returns ($result: $oset);
  ensures $phys_ptr_cast(SP#hd, ^d_node) == $phys_ptr_cast(SP#tl, ^d_node) ==> $result == $oset_empty();
  ensures $is_null($phys_ptr_cast(SP#hd, ^d_node)) && $phys_ptr_cast(SP#hd, ^d_node) != $phys_ptr_cast(SP#tl, ^d_node) ==> $result == $oset_empty();
  ensures $non_null($phys_ptr_cast(SP#hd, ^d_node)) && $phys_ptr_cast(SP#hd, ^d_node) != $phys_ptr_cast(SP#tl, ^d_node) ==> $oset_in($phys_ptr_cast(SP#hd, ^d_node), $result);
  ensures $non_null($phys_ptr_cast(SP#hd, ^d_node)) && $is_null($phys_ptr_cast(SP#tl, ^d_node)) ==> $result == F#dll_reach($s, $phys_ptr_cast(SP#hd, ^d_node));
  free ensures $result == F#dll_lseg_reach($s, SP#hd, SP#tl);
  free ensures $call_transition(old($s), $s);



procedure dl_dispose(P#a: $ptr, P#b: $ptr) returns (OP#ALL_REACH: $oset);
  requires F#dll($s, $phys_ptr_cast(P#a, ^d_node));
  requires F#dll($s, $phys_ptr_cast(P#b, ^d_node));
  requires F#dll_lseg($s, $phys_ptr_cast(P#a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
  requires $oset_disjoint(F#dll_lseg_reach($s, $phys_ptr_cast(P#a, ^d_node), $phys_ptr_cast(P#b, ^d_node)), F#dll_reach($s, $phys_ptr_cast(P#b, ^d_node)));
  requires $non_null($phys_ptr_cast(P#a, ^d_node)) ==> $is_null($rd_phys_ptr($s, d_node.prev, $phys_ptr_cast(P#a, ^d_node), ^d_node));
  requires $non_null($phys_ptr_cast(P#b, ^d_node)) ==> $is_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node));
  modifies $s, $cev_pc;
  ensures OP#ALL_REACH == $oset_empty();
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation dl_dispose(P#a: $ptr, P#b: $ptr) returns (OP#ALL_REACH: $oset)
{
  var stmtexpr2#7: $state;
  var SL#_dryad_S1: $state;
  var stmtexpr1#6: $state;
  var SL#_dryad_S0: $state;
  var stmtexpr0#5: $ptr;
  var SL#a0: $ptr;
  var loopState#0: $state;
  var L#prv: $ptr;
  var stmtexpr1#9: $oset;
  var stmtexpr0#8: $oset;
  var res_dll_lseg_reach#4: $oset;
  var res_dll_reach#3: $oset;
  var res_dll_reach#2: $oset;
  var SL#_dryad_G1: $oset;
  var SL#_dryad_G0: $oset;
  var local.a: $ptr;
  var #wrTime$2^3.3: int;
  var #stackframe: int;

  anon4:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$2^3.3, $s);
    assume $can_use_all_frame_axioms($s);
    assume #wrTime$2^3.3 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$2^3.3, (lambda #p: $ptr :: false));
    // assume true
    // assume true
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // struct d_node* local.a; 
    // local.a := a; 
    local.a := $phys_ptr_cast(P#a, ^d_node);
    //  --- Dryad annotated function --- 
    // _math \oset _dryad_G0; 
    // _math \oset _dryad_G1; 
    // _math \oset res_dll_reach#2; 
    // res_dll_reach#2 := dll_reach(local.a); 
    call res_dll_reach#2 := dll_reach($phys_ptr_cast(local.a, ^d_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _math \oset res_dll_reach#3; 
    // res_dll_reach#3 := dll_reach(b); 
    call res_dll_reach#3 := dll_reach($phys_ptr_cast(P#b, ^d_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _math \oset res_dll_lseg_reach#4; 
    // res_dll_lseg_reach#4 := dll_lseg_reach(local.a, b); 
    call res_dll_lseg_reach#4 := dll_lseg_reach($phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
    assume $full_stop_ext(#tok$3^0.0, $s);
    // _dryad_G0 := @_vcc_oset_union(@_vcc_oset_union(res_dll_reach#2, res_dll_reach#3), res_dll_lseg_reach#4); 
    SL#_dryad_G0 := $oset_union($oset_union(res_dll_reach#2, res_dll_reach#3), res_dll_lseg_reach#4);
    // _math \oset stmtexpr0#8; 
    // stmtexpr0#8 := _dryad_G0; 
    stmtexpr0#8 := SL#_dryad_G0;
    // _dryad_G1 := _dryad_G0; 
    SL#_dryad_G1 := SL#_dryad_G0;
    // _math \oset stmtexpr1#9; 
    // stmtexpr1#9 := _dryad_G1; 
    stmtexpr1#9 := SL#_dryad_G1;
    // assume ==>(@_vcc_ptr_neq_null(b), ==(dll(b), &&(&&(dll(*((b->next))), ==>(@_vcc_ptr_neq_null(*((b->next))), @_vcc_ptr_eq_pure(*((*((b->next))->prev)), b))), unchecked!(@_vcc_oset_in(b, dll_reach(*((b->next)))))))); 
    assume $non_null($phys_ptr_cast(P#b, ^d_node)) ==> F#dll($s, $phys_ptr_cast(P#b, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(P#b, ^d_node)) && !$oset_in($phys_ptr_cast(P#b, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node))));
    // assume ==>(@_vcc_ptr_neq_null(b), ==(dll_reach(b), @_vcc_oset_union(dll_reach(*((b->next))), @_vcc_oset_singleton(b)))); 
    assume $non_null($phys_ptr_cast(P#b, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(P#b, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(P#b, ^d_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll(local.a), &&(&&(dll(*((local.a->next))), ==>(@_vcc_ptr_neq_null(*((local.a->next))), @_vcc_ptr_eq_pure(*((*((local.a->next))->prev)), local.a))), unchecked!(@_vcc_oset_in(local.a, dll_reach(*((local.a->next)))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll($s, $phys_ptr_cast(local.a, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(local.a, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll_reach(local.a), @_vcc_oset_union(dll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
    // assume ==>(@_vcc_ptr_neq_pure(local.a, b), ==(dll_lseg(local.a, b), &&(dll_lseg(*((local.a->next)), b), unchecked!(@_vcc_oset_in(local.a, dll_lseg_reach(*((local.a->next)), b)))))); 
    assume $phys_ptr_cast(local.a, ^d_node) != $phys_ptr_cast(P#b, ^d_node) ==> F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == (F#dll_lseg($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node))));
    // assume ==>(@_vcc_ptr_neq_pure(local.a, b), ==(dll_lseg_reach(local.a, b), @_vcc_oset_union(dll_lseg_reach(*((local.a->next)), b), @_vcc_oset_singleton(local.a)))); 
    assume $phys_ptr_cast(local.a, ^d_node) != $phys_ptr_cast(P#b, ^d_node) ==> F#dll_lseg_reach($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == $oset_union(F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
    // struct d_node* prv; 
    // assume ==>(@_vcc_ptr_neq_null(local.a), &&(@_vcc_mutable(@state, local.a), @writes_check(local.a))); 
    assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^d_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^d_node));
    // assume ==>(@_vcc_ptr_neq_null(local.a), @_vcc_is_malloc_root(@state, local.a)); 
    assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $is_malloc_root($s, $phys_ptr_cast(local.a, ^d_node));
    // ALL_REACH := dll_reach(local.a); 
    call OP#ALL_REACH := dll_reach($phys_ptr_cast(local.a, ^d_node));
    assume $full_stop_ext(#tok$2^15.23, $s);
    // prv := (struct d_node*)@null; 
    L#prv := $phys_ptr_cast($null, ^d_node);
    // assert dll_lseg(prv, prv); 
    assert F#dll_lseg($s, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(L#prv, ^d_node));
    // assume dll_lseg(prv, prv); 
    assume F#dll_lseg($s, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(L#prv, ^d_node));
    // assert dll_lseg(b, b); 
    assert F#dll_lseg($s, $phys_ptr_cast(P#b, ^d_node), $phys_ptr_cast(P#b, ^d_node));
    // assume dll_lseg(b, b); 
    assume F#dll_lseg($s, $phys_ptr_cast(P#b, ^d_node), $phys_ptr_cast(P#b, ^d_node));
    // assert dll_lseg(local.a, local.a); 
    assert F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(local.a, ^d_node));
    // assume dll_lseg(local.a, local.a); 
    assume F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(local.a, ^d_node));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(dll(prv), &&(&&(dll(*((prv->next))), ==>(@_vcc_ptr_neq_null(*((prv->next))), @_vcc_ptr_eq_pure(*((*((prv->next))->prev)), prv))), unchecked!(@_vcc_oset_in(prv, dll_reach(*((prv->next)))))))); 
    assume $non_null($phys_ptr_cast(L#prv, ^d_node)) ==> F#dll($s, $phys_ptr_cast(L#prv, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(L#prv, ^d_node)) && !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node))));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(dll_reach(prv), @_vcc_oset_union(dll_reach(*((prv->next))), @_vcc_oset_singleton(prv)))); 
    assume $non_null($phys_ptr_cast(L#prv, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(L#prv, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(L#prv, ^d_node)));
    loopState#0 := $s;
    assume true;
    while (true)
      invariant F#dll($s, $phys_ptr_cast(local.a, ^d_node));
      invariant OP#ALL_REACH == F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node));
      invariant $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^d_node));
      invariant $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^d_node));
      invariant $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $is_malloc_root($s, $phys_ptr_cast(local.a, ^d_node));
    {
      anon3:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$2^18.3, $s);
        assume true;
        // if (@_vcc_ptr_neq_null(local.a)) ...
        if ($non_null($phys_ptr_cast(local.a, ^d_node)))
        {
          anon1:
            // assume ==>(@_vcc_ptr_neq_null(prv), ==(dll(prv), &&(&&(dll(*((prv->next))), ==>(@_vcc_ptr_neq_null(*((prv->next))), @_vcc_ptr_eq_pure(*((*((prv->next))->prev)), prv))), unchecked!(@_vcc_oset_in(prv, dll_reach(*((prv->next)))))))); 
            assume $non_null($phys_ptr_cast(L#prv, ^d_node)) ==> F#dll($s, $phys_ptr_cast(L#prv, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(L#prv, ^d_node)) && !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_null(prv), ==(dll_reach(prv), @_vcc_oset_union(dll_reach(*((prv->next))), @_vcc_oset_singleton(prv)))); 
            assume $non_null($phys_ptr_cast(L#prv, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(L#prv, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(L#prv, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_null(b), ==(dll(b), &&(&&(dll(*((b->next))), ==>(@_vcc_ptr_neq_null(*((b->next))), @_vcc_ptr_eq_pure(*((*((b->next))->prev)), b))), unchecked!(@_vcc_oset_in(b, dll_reach(*((b->next)))))))); 
            assume $non_null($phys_ptr_cast(P#b, ^d_node)) ==> F#dll($s, $phys_ptr_cast(P#b, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(P#b, ^d_node)) && !$oset_in($phys_ptr_cast(P#b, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_null(b), ==(dll_reach(b), @_vcc_oset_union(dll_reach(*((b->next))), @_vcc_oset_singleton(b)))); 
            assume $non_null($phys_ptr_cast(P#b, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(P#b, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(P#b, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll(local.a), &&(&&(dll(*((local.a->next))), ==>(@_vcc_ptr_neq_null(*((local.a->next))), @_vcc_ptr_eq_pure(*((*((local.a->next))->prev)), local.a))), unchecked!(@_vcc_oset_in(local.a, dll_reach(*((local.a->next)))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll($s, $phys_ptr_cast(local.a, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(local.a, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll_reach(local.a), @_vcc_oset_union(dll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_pure(local.a, b), ==(dll_lseg(local.a, b), &&(dll_lseg(*((local.a->next)), b), unchecked!(@_vcc_oset_in(local.a, dll_lseg_reach(*((local.a->next)), b)))))); 
            assume $phys_ptr_cast(local.a, ^d_node) != $phys_ptr_cast(P#b, ^d_node) ==> F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == (F#dll_lseg($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node))));
            // assume ==>(@_vcc_ptr_neq_pure(local.a, b), ==(dll_lseg_reach(local.a, b), @_vcc_oset_union(dll_lseg_reach(*((local.a->next)), b), @_vcc_oset_singleton(local.a)))); 
            assume $phys_ptr_cast(local.a, ^d_node) != $phys_ptr_cast(P#b, ^d_node) ==> F#dll_lseg_reach($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == $oset_union(F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // prv := local.a; 
            L#prv := $phys_ptr_cast(local.a, ^d_node);
            // assert dll_lseg(prv, prv); 
            assert F#dll_lseg($s, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(L#prv, ^d_node));
            // assume dll_lseg(prv, prv); 
            assume F#dll_lseg($s, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(L#prv, ^d_node));
            // assert dll_lseg(b, b); 
            assert F#dll_lseg($s, $phys_ptr_cast(P#b, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume dll_lseg(b, b); 
            assume F#dll_lseg($s, $phys_ptr_cast(P#b, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assert dll_lseg(local.a, local.a); 
            assert F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(local.a, ^d_node));
            // assume dll_lseg(local.a, local.a); 
            assume F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(local.a, ^d_node));
            // struct d_node* a0; 
            // a0 := local.a; 
            SL#a0 := $phys_ptr_cast(local.a, ^d_node);
            // struct d_node* stmtexpr0#5; 
            // stmtexpr0#5 := a0; 
            stmtexpr0#5 := $phys_ptr_cast(SL#a0, ^d_node);
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll(local.a), &&(&&(dll(*((local.a->next))), ==>(@_vcc_ptr_neq_null(*((local.a->next))), @_vcc_ptr_eq_pure(*((*((local.a->next))->prev)), local.a))), unchecked!(@_vcc_oset_in(local.a, dll_reach(*((local.a->next)))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll($s, $phys_ptr_cast(local.a, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(local.a, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll_reach(local.a), @_vcc_oset_union(dll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_pure(local.a, *((local.a->next))), ==(dll_lseg(local.a, *((local.a->next))), &&(dll_lseg(*((local.a->next)), *((local.a->next))), unchecked!(@_vcc_oset_in(local.a, dll_lseg_reach(*((local.a->next)), *((local.a->next)))))))); 
            assume $phys_ptr_cast(local.a, ^d_node) != $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node) ==> F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) == (F#dll_lseg($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_pure(local.a, *((local.a->next))), ==(dll_lseg_reach(local.a, *((local.a->next))), @_vcc_oset_union(dll_lseg_reach(*((local.a->next)), *((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $phys_ptr_cast(local.a, ^d_node) != $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node) ==> F#dll_lseg_reach($s, $phys_ptr_cast(local.a, ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) == $oset_union(F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // assert @reads_check_normal((local.a->next)); 
            assert $thread_local($s, $phys_ptr_cast(local.a, ^d_node));
            // local.a := *((local.a->next)); 
            local.a := $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node);
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll(local.a), &&(&&(dll(*((local.a->next))), ==>(@_vcc_ptr_neq_null(*((local.a->next))), @_vcc_ptr_eq_pure(*((*((local.a->next))->prev)), local.a))), unchecked!(@_vcc_oset_in(local.a, dll_reach(*((local.a->next)))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll($s, $phys_ptr_cast(local.a, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(local.a, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll_reach(local.a), @_vcc_oset_union(dll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll(local.a), &&(&&(dll(*((local.a->next))), ==>(@_vcc_ptr_neq_null(*((local.a->next))), @_vcc_ptr_eq_pure(*((*((local.a->next))->prev)), local.a))), unchecked!(@_vcc_oset_in(local.a, dll_reach(*((local.a->next)))))))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll($s, $phys_ptr_cast(local.a, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(local.a, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
            // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll_reach(local.a), @_vcc_oset_union(dll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_pure(local.a, b), ==(dll_lseg(local.a, b), &&(dll_lseg(*((local.a->next)), b), unchecked!(@_vcc_oset_in(local.a, dll_lseg_reach(*((local.a->next)), b)))))); 
            assume $phys_ptr_cast(local.a, ^d_node) != $phys_ptr_cast(P#b, ^d_node) ==> F#dll_lseg($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == (F#dll_lseg($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node))));
            // assume ==>(@_vcc_ptr_neq_pure(local.a, b), ==(dll_lseg_reach(local.a, b), @_vcc_oset_union(dll_lseg_reach(*((local.a->next)), b), @_vcc_oset_singleton(local.a)))); 
            assume $phys_ptr_cast(local.a, ^d_node) != $phys_ptr_cast(P#b, ^d_node) ==> F#dll_lseg_reach($s, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == $oset_union(F#dll_lseg_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), $phys_ptr_cast(P#b, ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
            // assume ==>(@_vcc_ptr_neq_null(local.a), &&(@_vcc_mutable(@state, local.a), @writes_check(local.a))); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $mutable($s, $phys_ptr_cast(local.a, ^d_node)) && $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(local.a, ^d_node));
            // assume ==>(@_vcc_ptr_neq_null(local.a), @_vcc_is_malloc_root(@state, local.a)); 
            assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> $is_malloc_root($s, $phys_ptr_cast(local.a, ^d_node));
            // _math \state _dryad_S0; 
            // _dryad_S0 := @_vcc_current_state(@state); 
            SL#_dryad_S0 := $current_state($s);
            // _math \state stmtexpr1#6; 
            // stmtexpr1#6 := _dryad_S0; 
            stmtexpr1#6 := SL#_dryad_S0;
            // void function
            // assert @writes_check(prv); 
            assert $top_writable($s, #wrTime$2^3.3, $phys_ptr_cast(L#prv, ^d_node));
            // assert @writes_check(@_vcc_extent(@state, prv)); 
            assert (forall #writes$2^28.5: $ptr :: { $dont_instantiate(#writes$2^28.5) } $set_in(#writes$2^28.5, $extent($s, $phys_ptr_cast(L#prv, ^d_node))) ==> $top_writable($s, #wrTime$2^3.3, #writes$2^28.5));
            // stmt _vcc_free(prv); 
            call $free($phys_ptr_cast(L#prv, ^d_node));
            assume $full_stop_ext(#tok$2^28.5, $s);
            // _math \state _dryad_S1; 
            // _dryad_S1 := @_vcc_current_state(@state); 
            SL#_dryad_S1 := $current_state($s);
            // _math \state stmtexpr2#7; 
            // stmtexpr2#7 := _dryad_S1; 
            stmtexpr2#7 := SL#_dryad_S1;
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_reach(a0)))), ==(old(_dryad_S0, dll(a0)), old(_dryad_S1, dll(a0)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#a0, ^d_node))) ==> F#dll(SL#_dryad_S0, $phys_ptr_cast(SL#a0, ^d_node)) == F#dll(SL#_dryad_S1, $phys_ptr_cast(SL#a0, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_reach(a0)))), ==(old(_dryad_S0, dll_reach(a0)), old(_dryad_S1, dll_reach(a0)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#a0, ^d_node))) ==> F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(SL#a0, ^d_node)) == F#dll_reach(SL#_dryad_S1, $phys_ptr_cast(SL#a0, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_reach(b)))), ==(old(_dryad_S0, dll(b)), old(_dryad_S1, dll(b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(P#b, ^d_node))) ==> F#dll(SL#_dryad_S0, $phys_ptr_cast(P#b, ^d_node)) == F#dll(SL#_dryad_S1, $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_reach(b)))), ==(old(_dryad_S0, dll_reach(b)), old(_dryad_S1, dll_reach(b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(P#b, ^d_node)) == F#dll_reach(SL#_dryad_S1, $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_reach(local.a)))), ==(old(_dryad_S0, dll(local.a)), old(_dryad_S1, dll(local.a)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node))) ==> F#dll(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node)) == F#dll(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_reach(local.a)))), ==(old(_dryad_S0, dll_reach(local.a)), old(_dryad_S1, dll_reach(local.a)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node))) ==> F#dll_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node)) == F#dll_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(local.a, b)))), ==(old(_dryad_S0, dll_lseg(local.a, b)), old(_dryad_S1, dll_lseg(local.a, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(local.a, b)))), ==(old(_dryad_S0, dll_lseg_reach(local.a, b)), old(_dryad_S1, dll_lseg_reach(local.a, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(prv, b)))), ==(old(_dryad_S0, dll_lseg(prv, b)), old(_dryad_S1, dll_lseg(prv, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg(SL#_dryad_S0, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg(SL#_dryad_S1, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(prv, b)))), ==(old(_dryad_S0, dll_lseg_reach(prv, b)), old(_dryad_S1, dll_lseg_reach(prv, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(L#prv, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(local.a, b)))), ==(old(_dryad_S0, dll_lseg(local.a, b)), old(_dryad_S1, dll_lseg(local.a, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(local.a, b)))), ==(old(_dryad_S0, dll_lseg_reach(local.a, b)), old(_dryad_S1, dll_lseg_reach(local.a, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(local.a, b)))), ==(old(_dryad_S0, dll_lseg(local.a, b)), old(_dryad_S1, dll_lseg(local.a, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // assume ==>(unchecked!(@_vcc_oset_in(prv, old(_dryad_S0, dll_lseg_reach(local.a, b)))), ==(old(_dryad_S0, dll_lseg_reach(local.a, b)), old(_dryad_S1, dll_lseg_reach(local.a, b)))); 
            assume !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node))) ==> F#dll_lseg_reach(SL#_dryad_S0, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node)) == F#dll_lseg_reach(SL#_dryad_S1, $phys_ptr_cast(local.a, ^d_node), $phys_ptr_cast(P#b, ^d_node));
            // ALL_REACH := @_vcc_oset_diff(ALL_REACH, @_vcc_oset_singleton(prv)); 
            OP#ALL_REACH := $oset_diff(OP#ALL_REACH, $oset_singleton($phys_ptr_cast(L#prv, ^d_node)));
        }
        else
        {
          anon2:
            // assert @_vcc_possibly_unreachable; 
            assert {:PossiblyUnreachable true} true;
            // goto #break_1; 
            goto #break_1;
        }

      #continue_1:
        assume true;
    }

  anon5:
    assume $full_stop_ext(#tok$2^18.3, $s);

  #break_1:
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(dll(prv), &&(&&(dll(*((prv->next))), ==>(@_vcc_ptr_neq_null(*((prv->next))), @_vcc_ptr_eq_pure(*((*((prv->next))->prev)), prv))), unchecked!(@_vcc_oset_in(prv, dll_reach(*((prv->next)))))))); 
    assume $non_null($phys_ptr_cast(L#prv, ^d_node)) ==> F#dll($s, $phys_ptr_cast(L#prv, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(L#prv, ^d_node)) && !$oset_in($phys_ptr_cast(L#prv, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node))));
    // assume ==>(@_vcc_ptr_neq_null(prv), ==(dll_reach(prv), @_vcc_oset_union(dll_reach(*((prv->next))), @_vcc_oset_singleton(prv)))); 
    assume $non_null($phys_ptr_cast(L#prv, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(L#prv, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(L#prv, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(L#prv, ^d_node)));
    // assume ==>(@_vcc_ptr_neq_null(b), ==(dll(b), &&(&&(dll(*((b->next))), ==>(@_vcc_ptr_neq_null(*((b->next))), @_vcc_ptr_eq_pure(*((*((b->next))->prev)), b))), unchecked!(@_vcc_oset_in(b, dll_reach(*((b->next)))))))); 
    assume $non_null($phys_ptr_cast(P#b, ^d_node)) ==> F#dll($s, $phys_ptr_cast(P#b, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(P#b, ^d_node)) && !$oset_in($phys_ptr_cast(P#b, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node))));
    // assume ==>(@_vcc_ptr_neq_null(b), ==(dll_reach(b), @_vcc_oset_union(dll_reach(*((b->next))), @_vcc_oset_singleton(b)))); 
    assume $non_null($phys_ptr_cast(P#b, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(P#b, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(P#b, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(P#b, ^d_node)));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll(local.a), &&(&&(dll(*((local.a->next))), ==>(@_vcc_ptr_neq_null(*((local.a->next))), @_vcc_ptr_eq_pure(*((*((local.a->next))->prev)), local.a))), unchecked!(@_vcc_oset_in(local.a, dll_reach(*((local.a->next)))))))); 
    assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll($s, $phys_ptr_cast(local.a, ^d_node)) == (F#dll($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) && ($non_null($rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)) ==> $rd_phys_ptr($s, d_node.prev, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node), ^d_node) == $phys_ptr_cast(local.a, ^d_node)) && !$oset_in($phys_ptr_cast(local.a, ^d_node), F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node))));
    // assume ==>(@_vcc_ptr_neq_null(local.a), ==(dll_reach(local.a), @_vcc_oset_union(dll_reach(*((local.a->next))), @_vcc_oset_singleton(local.a)))); 
    assume $non_null($phys_ptr_cast(local.a, ^d_node)) ==> F#dll_reach($s, $phys_ptr_cast(local.a, ^d_node)) == $oset_union(F#dll_reach($s, $rd_phys_ptr($s, d_node.next, $phys_ptr_cast(local.a, ^d_node), ^d_node)), $oset_singleton($phys_ptr_cast(local.a, ^d_node)));
    // return; 
    assume true;
    assert $position_marker();
    goto #exit;

  #exit:
}



const unique l#public: $label;

const unique #tok$2^28.5: $token;

const unique #tok$2^18.3: $token;

const unique #tok$2^15.23: $token;

const unique #tok$3^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(3, #file^?3Cno?20file?3E);

const unique #tok$2^3.3: $token;

const unique #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Cdl?5Cdl_dispose.c: $token;

axiom $file_name_is(2, #file^Z?3A?5CInvariantSynthesis?5Csubmit?5Cgrass?5Cdl?5Cdl_dispose.c);

const unique #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Cdl?5Cdryad_dl.h: $token;

axiom $file_name_is(1, #file^z?3A?5Cinvariantsynthesis?5Csubmit?5Cgrass?5Cdl?5Cdryad_dl.h);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^d_node);
