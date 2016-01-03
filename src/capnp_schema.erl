-file("capnp_schema.erl", 1).

-module(capnp_schema).

-include_lib("include/capnp_schema.hrl").

-compile([export_all]).

massage_bool_list(List) ->
    try lists:split(8, List) of
        {First,Last} ->
            lists:reverse(First) ++ massage_bool_list(Last)
    catch
        error:badarg ->
            lists:reverse(List
                          ++
                          lists:duplicate(- length(List) band 7, 0))
    end.

decode_envelope(<<RawSegCount:32/little-unsigned-integer,Rest/binary>>) ->
    SegLengthLength = RawSegCount + 1 bsr 1 bsl 1 + 1 bsl 2,
    <<SegLengthData:SegLengthLength/binary,SegData/binary>> = Rest,
    SegLengths =
        [ 
         X bsl 3 ||
             <<X:32/little-unsigned-integer>> <= SegLengthData,
             X > 0
        ],
    {SegsR,Dregs} =
        lists:foldl(fun(Length, {SplitSegs,Data}) ->
                           <<Seg:Length/binary,Remain/binary>> = Data,
                           {[Seg|SplitSegs],Remain}
                    end,
                    {[],SegData},
                    SegLengths),
    Segs = lists:reverse(SegsR),
    <<Ptr:64/little-unsigned-integer,_/binary>> = hd(Segs),
    {#message_ref{current_offset = 0,
                  current_segment = hd(Segs),
                  segments = Segs},
     Ptr,
     Dregs}.

'decode_schema.capnp:Annotation'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Annotation'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Brand'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Brand.Binding'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand.Binding'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Brand.Scope'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand.Scope'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Brand.Scope.'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand.Scope.'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:CodeGeneratorRequest'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:CodeGeneratorRequest'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:CodeGeneratorRequest.RequestedFile'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:CodeGeneratorRequest.RequestedFile'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Enumerant'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Enumerant'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Field'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Field'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Field.'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Field.'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Field.group'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Field.group'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Field.ordinal'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Field.ordinal'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Field.slot'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Field.slot'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Method'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Method'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.NestedNode'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.NestedNode'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.Parameter'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.Parameter'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.annotation'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.annotation'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.const'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.const'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.enum'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.enum'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.interface'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.interface'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Node.struct'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Node.struct'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Superclass'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Superclass'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.anyPointer'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.anyPointer'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.anyPointer.implicitMethodParameter'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.anyPointer.implicitMethodParameter'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.anyPointer.parameter'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.anyPointer.parameter'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.enum'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.enum'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.interface'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.interface'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.list'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.list'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Type.struct'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type.struct'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

'decode_schema.capnp:Value'(Data) ->
    {MessageRef,Ptr,Dregs} = decode_envelope(Data),
    Decoded =
        follow_struct_pointer(fun 'internal_decode_schema.capnp:Value'/2,
                              Ptr,
                              MessageRef),
    {Decoded,Dregs}.

decode_struct_list(DecodeFun, Length, DWords, PWords, MessageRef) ->
    Offset = MessageRef#message_ref.current_offset,
    SkipBits = Offset * 64,
    <<_:SkipBits,Rest/binary>> = MessageRef#message_ref.current_segment,
    Words = DWords + PWords,
    Bits = Words * 64,
    {_,ListR} =
        lists:foldl(fun(N, {OldRest,Acc}) ->
                           <<ThisData:Bits/bitstring,NewRest/binary>> =
                               OldRest,
                           New =
                               DecodeFun(ThisData,
                                         MessageRef#message_ref{current_offset =
                                                                    Offset
                                                                    +
                                                                    Words
                                                                    *
                                                                    N}),
                           {NewRest,[New|Acc]}
                    end,
                    {Rest,[]},
                    lists:seq(0, Length - 1)),
    lists:reverse(ListR).

'encode_schema.capnp:Annotation'(#'schema.capnp:Annotation'{id = Varid,
                                                            value =
                                                                Varvalue,
                                                            brand =
                                                                Varbrand},
                                 PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrIntvalue,MainLenvalue,ExtraLenvalue,Data1,Extra1} =
        'encode_schema.capnp:Value'(Varvalue, 0),
    Ptrvalue =
        case ZeroOffsetPtrIntvalue of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 1 bsl 2 + ZeroOffsetPtrIntvalue
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLenvalue + ExtraLenvalue,
    {ZeroOffsetPtrIntbrand,MainLenbrand,ExtraLenbrand,Data2,Extra2} =
        'encode_schema.capnp:Brand'(Varbrand, 0),
    Ptrbrand =
        case ZeroOffsetPtrIntbrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd1 + 0 bsl 2 + ZeroOffsetPtrIntbrand
        end,
    PtrOffsetWordsFromEnd2 =
        PtrOffsetWordsFromEnd1 + MainLenbrand + ExtraLenbrand,
    {562954248388608,
     3,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<Varid:64/little-unsigned-integer,
       Ptrvalue:64/little-unsigned-integer,
       Ptrbrand:64/little-unsigned-integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:Annotation'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Brand'(#'schema.capnp:Brand'{scopes = Varscopes},
                            PtrOffsetWordsFromEnd0) ->
    if
        Varscopes =/= undefined ->
            DataLenscopes = length(Varscopes),
            {FinalOffsetscopes,Data1,Extra1} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {281483566645248,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Brand.Scope'(Element,
                                                                         Offset
                                                                         -
                                                                         3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenscopes * 3,
                             [<<(DataLenscopes bsl 2 + 281483566645248):64/unsigned-little-integer>>],
                             []},
                            Varscopes),
            FinalOffsetscopes = round(iolist_size(Extra1) / 8),
            Ptrscopes =
                1 bor (0 + PtrOffsetWordsFromEnd0 bsl 2) bor (7 bsl 32)
                bor
                (DataLenscopes * 3 bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + 1 + DataLenscopes * 3
                +
                FinalOffsetscopes;
        true ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrscopes = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    {281474976710656,
     1,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<Ptrscopes:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Brand'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Brand.Binding'({VarDiscriminant,Var},
                                    PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        unbound ->
            {281479271677952,
             2,
             0,
             <<0:16/little-unsigned-integer,0:48/integer,0:64/integer>>,
             []};
        type ->
            {ZeroOffsetPtrInt,MainLen,ExtraLen,Data1,Extra1} =
                'encode_schema.capnp:Type'(Var, 0),
            Ptr =
                case ZeroOffsetPtrInt of
                    0 ->
                        0;
                    _ ->
                        PtrOffsetWordsFromEnd0 + 0 bsl 2
                        +
                        ZeroOffsetPtrInt
                end,
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + MainLen + ExtraLen,
            {281479271677952,
             2,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<1:16/little-unsigned-integer,
               0:48/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]}
    end.

'encode_schema.capnp:Brand.Scope'(#'schema.capnp:Brand.Scope'{scopeId =
                                                                  VarscopeId,
                                                              '' = Var},
                                  PtrOffsetWordsFromEnd0) ->
    <<NoGroupBodyDataAsInt:192/integer>> =
        <<VarscopeId:64/little-unsigned-integer,
          0:64/integer,
          0:64/integer>>,
    {_ZeroOffsetPtrInt,_NewBodyLen,ExtraDataLen,BodyData,ExtraData} =
        'encode_schema.capnp:Brand.Scope.'(Var,
                                           PtrOffsetWordsFromEnd0
                                           -
                                           PtrOffsetWordsFromEnd0),
    <<BodyDataAsIntFrom:192/integer>> = BodyData,
    {281483566645248,
     3,
     PtrOffsetWordsFromEnd0 - PtrOffsetWordsFromEnd0 + ExtraDataLen,
     <<(NoGroupBodyDataAsInt bor BodyDataAsIntFrom):192/integer>>,
     [[]|ExtraData]};
'encode_schema.capnp:Brand.Scope'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Brand.Scope.'({VarDiscriminant,Var},
                                   PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        bind ->
            if
                Var =/= undefined ->
                    DataLen = length(Var),
                    {FinalOffset,Data1,Extra1} =
                        lists:foldl(fun(Element,
                                        {Offset,DataAcc,ExtraAcc}) ->
                                           {281479271677952,
                                            2,
                                            ExtraLen,
                                            ThisBody,
                                            ThisExtra} =
                                               'encode_schema.capnp:Brand.Binding'(Element,
                                                                                   Offset
                                                                                   -
                                                                                   2),
                                           {ExtraLen + Offset - 2,
                                            [DataAcc,ThisBody],
                                            [ExtraAcc|ThisExtra]}
                                    end,
                                    {DataLen * 2,
                                     [<<(DataLen bsl 2 + 281479271677952):64/unsigned-little-integer>>],
                                     []},
                                    Var),
                    FinalOffset = round(iolist_size(Extra1) / 8),
                    Ptr =
                        1 bor (0 + PtrOffsetWordsFromEnd0 bsl 2)
                        bor
                        (7 bsl 32)
                        bor
                        (DataLen * 2 bsl 35),
                    PtrOffsetWordsFromEnd1 =
                        PtrOffsetWordsFromEnd0 + 1 + DataLen * 2
                        +
                        FinalOffset;
                true ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {281483566645248,
             3,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<0:64/integer,
               0:16/little-unsigned-integer,
               0:48/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]};
        inherit ->
            {281483566645248,
             3,
             0,
             <<case Var of
                   undefined ->
                       0
               end:0/integer,
               0:64/integer,
               1:16/little-unsigned-integer,
               0:48/integer,
               0:64/integer>>,
             []}
    end.

'encode_schema.capnp:CodeGeneratorRequest'(#'schema.capnp:CodeGeneratorRequest'{nodes =
                                                                                    Varnodes,
                                                                                requestedFiles =
                                                                                    VarrequestedFiles},
                                           PtrOffsetWordsFromEnd0) ->
    if
        Varnodes =/= undefined ->
            DataLennodes = length(Varnodes),
            {FinalOffsetnodes,Data1,Extra1} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {1688871335100416,
                                    11,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Node'(Element,
                                                                  Offset
                                                                  -
                                                                  11),
                                   {ExtraLen + Offset - 11,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLennodes * 11,
                             [<<(DataLennodes bsl 2 + 1688871335100416):64/unsigned-little-integer>>],
                             []},
                            Varnodes),
            FinalOffsetnodes = round(iolist_size(Extra1) / 8),
            Ptrnodes =
                1 bor (1 + PtrOffsetWordsFromEnd0 bsl 2) bor (7 bsl 32)
                bor
                (DataLennodes * 11 bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + 1 + DataLennodes * 11
                +
                FinalOffsetnodes;
        true ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrnodes = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        VarrequestedFiles =/= undefined ->
            DataLenrequestedFiles = length(VarrequestedFiles),
            {FinalOffsetrequestedFiles,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {562954248388608,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:CodeGeneratorRequest.RequestedFile'(Element,
                                                                                                Offset
                                                                                                -
                                                                                                3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenrequestedFiles * 3,
                             [<<(DataLenrequestedFiles bsl 2
                                 +
                                 562954248388608):64/unsigned-little-integer>>],
                             []},
                            VarrequestedFiles),
            FinalOffsetrequestedFiles = round(iolist_size(Extra2) / 8),
            PtrrequestedFiles =
                1 bor (0 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLenrequestedFiles * 3 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLenrequestedFiles * 3
                +
                FinalOffsetrequestedFiles;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            PtrrequestedFiles = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    {562949953421312,
     2,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<Ptrnodes:64/little-unsigned-integer,
       PtrrequestedFiles:64/little-unsigned-integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:CodeGeneratorRequest'(undefined,
                                           _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:CodeGeneratorRequest.RequestedFile'(#'schema.capnp:CodeGeneratorRequest.RequestedFile'{id =
                                                                                                                Varid,
                                                                                                            filename =
                                                                                                                Varfilename,
                                                                                                            imports =
                                                                                                                Varimports},
                                                         PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varfilename);is_binary(Varfilename) ->
            Extra1 = <<>>,
            DataLenfilename = iolist_size(Varfilename) + 1,
            Data1 =
                [Varfilename,
                 <<0:8,
                   0:(- DataLenfilename band 7 * 8)/unsigned-little-integer>>],
            Ptrfilename =
                1 bor (PtrOffsetWordsFromEnd0 + 1 bsl 2) bor (2 bsl 32)
                bor
                (DataLenfilename bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenfilename + 7 bsr 3);
        Varfilename =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrfilename = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        Varimports =/= undefined ->
            DataLenimports = length(Varimports),
            {FinalOffsetimports,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {281479271677952,
                                    2,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(Element,
                                                                                                       Offset
                                                                                                       -
                                                                                                       2),
                                   {ExtraLen + Offset - 2,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenimports * 2,
                             [<<(DataLenimports bsl 2 + 281479271677952):64/unsigned-little-integer>>],
                             []},
                            Varimports),
            FinalOffsetimports = round(iolist_size(Extra2) / 8),
            Ptrimports =
                1 bor (0 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLenimports * 2 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLenimports * 2
                +
                FinalOffsetimports;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            Ptrimports = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    {562954248388608,
     3,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<Varid:64/little-unsigned-integer,
       Ptrfilename:64/little-unsigned-integer,
       Ptrimports:64/little-unsigned-integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:CodeGeneratorRequest.RequestedFile'(undefined,
                                                         _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(#'schema.capnp:CodeGeneratorRequest.RequestedFile.Import'{id =
                                                                                                                              Varid,
                                                                                                                          name =
                                                                                                                              Varname},
                                                                PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varname);is_binary(Varname) ->
            Extra1 = <<>>,
            DataLenname = iolist_size(Varname) + 1,
            Data1 =
                [Varname,
                 <<0:8,
                   0:(- DataLenname band 7 * 8)/unsigned-little-integer>>],
            Ptrname =
                1 bor (PtrOffsetWordsFromEnd0 + 0 bsl 2) bor (2 bsl 32)
                bor
                (DataLenname bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenname + 7 bsr 3);
        Varname =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrname = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    {281479271677952,
     2,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<Varid:64/little-unsigned-integer,
       Ptrname:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(undefined,
                                                                _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Enumerant'(#'schema.capnp:Enumerant'{codeOrder =
                                                              VarcodeOrder,
                                                          name = Varname,
                                                          annotations =
                                                              Varannotations},
                                PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varname);is_binary(Varname) ->
            Extra1 = <<>>,
            DataLenname = iolist_size(Varname) + 1,
            Data1 =
                [Varname,
                 <<0:8,
                   0:(- DataLenname band 7 * 8)/unsigned-little-integer>>],
            Ptrname =
                1 bor (PtrOffsetWordsFromEnd0 + 1 bsl 2) bor (2 bsl 32)
                bor
                (DataLenname bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenname + 7 bsr 3);
        Varname =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrname = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        Varannotations =/= undefined ->
            DataLenannotations = length(Varannotations),
            {FinalOffsetannotations,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {562954248388608,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Annotation'(Element,
                                                                        Offset
                                                                        -
                                                                        3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenannotations * 3,
                             [<<(DataLenannotations bsl 2
                                 +
                                 562954248388608):64/unsigned-little-integer>>],
                             []},
                            Varannotations),
            FinalOffsetannotations = round(iolist_size(Extra2) / 8),
            Ptrannotations =
                1 bor (0 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLenannotations * 3 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLenannotations * 3
                +
                FinalOffsetannotations;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            Ptrannotations = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    {562954248388608,
     3,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<VarcodeOrder:16/little-unsigned-integer,
       0:48/integer,
       Ptrname:64/little-unsigned-integer,
       Ptrannotations:64/little-unsigned-integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:Enumerant'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Field'(#'schema.capnp:Field'{codeOrder =
                                                      VarcodeOrder,
                                                  discriminantValue =
                                                      VardiscriminantValue,
                                                  name = Varname,
                                                  annotations =
                                                      Varannotations,
                                                  '' = Var,
                                                  ordinal = Varordinal},
                            PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varname);is_binary(Varname) ->
            Extra1 = <<>>,
            DataLenname = iolist_size(Varname) + 1,
            Data1 =
                [Varname,
                 <<0:8,
                   0:(- DataLenname band 7 * 8)/unsigned-little-integer>>],
            Ptrname =
                1 bor (PtrOffsetWordsFromEnd0 + 3 bsl 2) bor (2 bsl 32)
                bor
                (DataLenname bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenname + 7 bsr 3);
        Varname =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrname = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        Varannotations =/= undefined ->
            DataLenannotations = length(Varannotations),
            {FinalOffsetannotations,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {562954248388608,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Annotation'(Element,
                                                                        Offset
                                                                        -
                                                                        3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenannotations * 3,
                             [<<(DataLenannotations bsl 2
                                 +
                                 562954248388608):64/unsigned-little-integer>>],
                             []},
                            Varannotations),
            FinalOffsetannotations = round(iolist_size(Extra2) / 8),
            Ptrannotations =
                1 bor (2 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLenannotations * 3 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLenannotations * 3
                +
                FinalOffsetannotations;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            Ptrannotations = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    <<NoGroupBodyDataAsInt:448/integer>> =
        <<VarcodeOrder:16/little-unsigned-integer,
          (VardiscriminantValue bxor 65535):16/little-unsigned-integer,
          0:160/integer,
          Ptrname:64/little-unsigned-integer,
          Ptrannotations:64/little-unsigned-integer,
          0:128/integer>>,
    {_ZeroOffsetPtrInt,_NewBodyLen,ExtraDataLen,BodyData,ExtraData} =
        'encode_schema.capnp:Field.'(Var,
                                     PtrOffsetWordsFromEnd2
                                     -
                                     PtrOffsetWordsFromEnd0),
    <<BodyDataAsIntFrom:448/integer>> = BodyData,
    {_ZeroOffsetPtrIntordinal,
     _NewBodyLenordinal,
     ExtraDataLenordinal,
     BodyDataordinal,
     ExtraDataordinal} =
        'encode_schema.capnp:Field.ordinal'(Varordinal,
                                            PtrOffsetWordsFromEnd2
                                            -
                                            PtrOffsetWordsFromEnd0
                                            +
                                            ExtraDataLen),
    <<BodyDataAsIntFromordinal:448/integer>> = BodyDataordinal,
    {1125912791744512,
     7,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0 + ExtraDataLen
     +
     ExtraDataLenordinal,
     <<(NoGroupBodyDataAsInt bor BodyDataAsIntFrom
        bor
        BodyDataAsIntFromordinal):448/integer>>,
     [[[Data1,Extra1,Data2,Extra2]|ExtraData]|ExtraDataordinal]};
'encode_schema.capnp:Field'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Field.'({VarDiscriminant,Var},
                             PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        slot ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:448/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Field.slot'(Var,
                                                 PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (0 bsl 64)):448/little-unsigned-integer>>,
             ExtraData};
        group ->
            {1125912791744512,
             7,
             0,
             <<0:64/integer,
               1:16/little-unsigned-integer,
               0:48/integer,
               Var:64/little-unsigned-integer,
               0:256/integer>>,
             []}
    end.

'encode_schema.capnp:Field.group'(#'schema.capnp:Field.group'{typeId =
                                                                  VartypeId},
                                  PtrOffsetWordsFromEnd0) ->
    {1125912791744512,
     7,
     PtrOffsetWordsFromEnd0 - PtrOffsetWordsFromEnd0,
     <<0:128/integer,VartypeId:64/little-unsigned-integer,0:256/integer>>,
     []};
'encode_schema.capnp:Field.group'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Field.ordinal'({VarDiscriminant,Var},
                                    PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        implicit ->
            {1125912791744512,
             7,
             0,
             <<case Var of
                   undefined ->
                       0
               end:0/integer,
               0:80/integer,
               0:16/little-unsigned-integer,
               0:96/integer,
               0:256/integer>>,
             []};
        explicit ->
            {1125912791744512,
             7,
             0,
             <<0:80/integer,
               1:16/little-unsigned-integer,
               Var:16/little-unsigned-integer,
               0:80/integer,
               0:256/integer>>,
             []}
    end.

'encode_schema.capnp:Field.slot'(#'schema.capnp:Field.slot'{offset =
                                                                Varoffset,
                                                            hadExplicitDefault =
                                                                VarhadExplicitDefault,
                                                            type =
                                                                Vartype,
                                                            defaultValue =
                                                                VardefaultValue},
                                 PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrInttype,MainLentype,ExtraLentype,Data1,Extra1} =
        'encode_schema.capnp:Type'(Vartype, 0),
    Ptrtype =
        case ZeroOffsetPtrInttype of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 1 bsl 2 + ZeroOffsetPtrInttype
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLentype + ExtraLentype,
    {ZeroOffsetPtrIntdefaultValue,
     MainLendefaultValue,
     ExtraLendefaultValue,
     Data2,
     Extra2} =
        'encode_schema.capnp:Value'(VardefaultValue, 0),
    PtrdefaultValue =
        case ZeroOffsetPtrIntdefaultValue of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd1 + 0 bsl 2
                +
                ZeroOffsetPtrIntdefaultValue
        end,
    PtrOffsetWordsFromEnd2 =
        PtrOffsetWordsFromEnd1 + MainLendefaultValue
        +
        ExtraLendefaultValue,
    {1125912791744512,
     7,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<0:32/integer,
       Varoffset:32/little-unsigned-integer,
       0:71/integer,
       case VarhadExplicitDefault of
           false ->
               0;
           true ->
               1
       end:1/integer,
       0:56/integer,
       0:128/integer,
       Ptrtype:64/little-unsigned-integer,
       PtrdefaultValue:64/little-unsigned-integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:Field.slot'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Method'(#'schema.capnp:Method'{codeOrder =
                                                        VarcodeOrder,
                                                    paramStructType =
                                                        VarparamStructType,
                                                    resultStructType =
                                                        VarresultStructType,
                                                    name = Varname,
                                                    annotations =
                                                        Varannotations,
                                                    paramBrand =
                                                        VarparamBrand,
                                                    resultBrand =
                                                        VarresultBrand,
                                                    implicitParameters =
                                                        VarimplicitParameters},
                             PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varname);is_binary(Varname) ->
            Extra1 = <<>>,
            DataLenname = iolist_size(Varname) + 1,
            Data1 =
                [Varname,
                 <<0:8,
                   0:(- DataLenname band 7 * 8)/unsigned-little-integer>>],
            Ptrname =
                1 bor (PtrOffsetWordsFromEnd0 + 4 bsl 2) bor (2 bsl 32)
                bor
                (DataLenname bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenname + 7 bsr 3);
        Varname =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrname = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        Varannotations =/= undefined ->
            DataLenannotations = length(Varannotations),
            {FinalOffsetannotations,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {562954248388608,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Annotation'(Element,
                                                                        Offset
                                                                        -
                                                                        3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenannotations * 3,
                             [<<(DataLenannotations bsl 2
                                 +
                                 562954248388608):64/unsigned-little-integer>>],
                             []},
                            Varannotations),
            FinalOffsetannotations = round(iolist_size(Extra2) / 8),
            Ptrannotations =
                1 bor (3 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLenannotations * 3 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLenannotations * 3
                +
                FinalOffsetannotations;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            Ptrannotations = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    {ZeroOffsetPtrIntparamBrand,
     MainLenparamBrand,
     ExtraLenparamBrand,
     Data3,
     Extra3} =
        'encode_schema.capnp:Brand'(VarparamBrand, 0),
    PtrparamBrand =
        case ZeroOffsetPtrIntparamBrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd2 + 2 bsl 2
                +
                ZeroOffsetPtrIntparamBrand
        end,
    PtrOffsetWordsFromEnd3 =
        PtrOffsetWordsFromEnd2 + MainLenparamBrand + ExtraLenparamBrand,
    {ZeroOffsetPtrIntresultBrand,
     MainLenresultBrand,
     ExtraLenresultBrand,
     Data4,
     Extra4} =
        'encode_schema.capnp:Brand'(VarresultBrand, 0),
    PtrresultBrand =
        case ZeroOffsetPtrIntresultBrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd3 + 1 bsl 2
                +
                ZeroOffsetPtrIntresultBrand
        end,
    PtrOffsetWordsFromEnd4 =
        PtrOffsetWordsFromEnd3 + MainLenresultBrand
        +
        ExtraLenresultBrand,
    if
        VarimplicitParameters =/= undefined ->
            DataLenimplicitParameters = length(VarimplicitParameters),
            {FinalOffsetimplicitParameters,Data5,Extra5} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {281474976710656,
                                    1,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Node.Parameter'(Element,
                                                                            Offset
                                                                            -
                                                                            1),
                                   {ExtraLen + Offset - 1,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenimplicitParameters * 1,
                             [<<(DataLenimplicitParameters bsl 2
                                 +
                                 281474976710656):64/unsigned-little-integer>>],
                             []},
                            VarimplicitParameters),
            FinalOffsetimplicitParameters =
                round(iolist_size(Extra5) / 8),
            PtrimplicitParameters =
                1 bor (0 + PtrOffsetWordsFromEnd4 bsl 2) bor (7 bsl 32)
                bor
                (DataLenimplicitParameters * 1 bsl 35),
            PtrOffsetWordsFromEnd5 =
                PtrOffsetWordsFromEnd4 + 1
                +
                DataLenimplicitParameters * 1
                +
                FinalOffsetimplicitParameters;
        true ->
            Extra5 = <<>>,
            Data5 = [],
            PtrimplicitParameters = 0,
            PtrOffsetWordsFromEnd5 = PtrOffsetWordsFromEnd4
    end,
    {1407387768455168,
     8,
     PtrOffsetWordsFromEnd5 - PtrOffsetWordsFromEnd0,
     <<VarcodeOrder:16/little-unsigned-integer,
       0:48/integer,
       VarparamStructType:64/little-unsigned-integer,
       VarresultStructType:64/little-unsigned-integer,
       Ptrname:64/little-unsigned-integer,
       Ptrannotations:64/little-unsigned-integer,
       PtrparamBrand:64/little-unsigned-integer,
       PtrresultBrand:64/little-unsigned-integer,
       PtrimplicitParameters:64/little-unsigned-integer>>,
     [Data1,Extra1,Data2,Extra2,Data3,Extra3,Data4,Extra4,Data5,Extra5]};
'encode_schema.capnp:Method'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node'(#'schema.capnp:Node'{id = Varid,
                                                displayNamePrefixLength =
                                                    VardisplayNamePrefixLength,
                                                scopeId = VarscopeId,
                                                isGeneric = VarisGeneric,
                                                displayName =
                                                    VardisplayName,
                                                nestedNodes =
                                                    VarnestedNodes,
                                                annotations =
                                                    Varannotations,
                                                parameters =
                                                    Varparameters,
                                                '' = Var},
                           PtrOffsetWordsFromEnd0) ->
    if
        is_list(VardisplayName);is_binary(VardisplayName) ->
            Extra1 = <<>>,
            DataLendisplayName = iolist_size(VardisplayName) + 1,
            Data1 =
                [VardisplayName,
                 <<0:8,
                   0:(- DataLendisplayName band 7 * 8)/unsigned-little-integer>>],
            PtrdisplayName =
                1 bor (PtrOffsetWordsFromEnd0 + 5 bsl 2) bor (2 bsl 32)
                bor
                (DataLendisplayName bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLendisplayName + 7 bsr 3);
        VardisplayName =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            PtrdisplayName = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        VarnestedNodes =/= undefined ->
            DataLennestedNodes = length(VarnestedNodes),
            {FinalOffsetnestedNodes,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {281479271677952,
                                    2,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Node.NestedNode'(Element,
                                                                             Offset
                                                                             -
                                                                             2),
                                   {ExtraLen + Offset - 2,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLennestedNodes * 2,
                             [<<(DataLennestedNodes bsl 2
                                 +
                                 281479271677952):64/unsigned-little-integer>>],
                             []},
                            VarnestedNodes),
            FinalOffsetnestedNodes = round(iolist_size(Extra2) / 8),
            PtrnestedNodes =
                1 bor (4 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLennestedNodes * 2 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLennestedNodes * 2
                +
                FinalOffsetnestedNodes;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            PtrnestedNodes = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    if
        Varannotations =/= undefined ->
            DataLenannotations = length(Varannotations),
            {FinalOffsetannotations,Data3,Extra3} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {562954248388608,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Annotation'(Element,
                                                                        Offset
                                                                        -
                                                                        3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenannotations * 3,
                             [<<(DataLenannotations bsl 2
                                 +
                                 562954248388608):64/unsigned-little-integer>>],
                             []},
                            Varannotations),
            FinalOffsetannotations = round(iolist_size(Extra3) / 8),
            Ptrannotations =
                1 bor (3 + PtrOffsetWordsFromEnd2 bsl 2) bor (7 bsl 32)
                bor
                (DataLenannotations * 3 bsl 35),
            PtrOffsetWordsFromEnd3 =
                PtrOffsetWordsFromEnd2 + 1 + DataLenannotations * 3
                +
                FinalOffsetannotations;
        true ->
            Extra3 = <<>>,
            Data3 = [],
            Ptrannotations = 0,
            PtrOffsetWordsFromEnd3 = PtrOffsetWordsFromEnd2
    end,
    if
        Varparameters =/= undefined ->
            DataLenparameters = length(Varparameters),
            {FinalOffsetparameters,Data4,Extra4} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {281474976710656,
                                    1,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Node.Parameter'(Element,
                                                                            Offset
                                                                            -
                                                                            1),
                                   {ExtraLen + Offset - 1,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenparameters * 1,
                             [<<(DataLenparameters bsl 2
                                 +
                                 281474976710656):64/unsigned-little-integer>>],
                             []},
                            Varparameters),
            FinalOffsetparameters = round(iolist_size(Extra4) / 8),
            Ptrparameters =
                1 bor (0 + PtrOffsetWordsFromEnd3 bsl 2) bor (7 bsl 32)
                bor
                (DataLenparameters * 1 bsl 35),
            PtrOffsetWordsFromEnd4 =
                PtrOffsetWordsFromEnd3 + 1 + DataLenparameters * 1
                +
                FinalOffsetparameters;
        true ->
            Extra4 = <<>>,
            Data4 = [],
            Ptrparameters = 0,
            PtrOffsetWordsFromEnd4 = PtrOffsetWordsFromEnd3
    end,
    <<NoGroupBodyDataAsInt:704/integer>> =
        <<Varid:64/little-unsigned-integer,
          VardisplayNamePrefixLength:32/little-unsigned-integer,
          0:32/integer,
          VarscopeId:64/little-unsigned-integer,
          0:103/integer,
          case VarisGeneric of
              false ->
                  0;
              true ->
                  1
          end:1/integer,
          0:24/integer,
          PtrdisplayName:64/little-unsigned-integer,
          PtrnestedNodes:64/little-unsigned-integer,
          Ptrannotations:64/little-unsigned-integer,
          0:128/integer,
          Ptrparameters:64/little-unsigned-integer>>,
    {_ZeroOffsetPtrInt,_NewBodyLen,ExtraDataLen,BodyData,ExtraData} =
        'encode_schema.capnp:Node.'(Var,
                                    PtrOffsetWordsFromEnd4
                                    -
                                    PtrOffsetWordsFromEnd0),
    <<BodyDataAsIntFrom:704/integer>> = BodyData,
    {1688871335100416,
     11,
     PtrOffsetWordsFromEnd4 - PtrOffsetWordsFromEnd0 + ExtraDataLen,
     <<(NoGroupBodyDataAsInt bor BodyDataAsIntFrom):704/integer>>,
     [[Data1,Extra1,Data2,Extra2,Data3,Extra3,Data4,Extra4]|ExtraData]};
'encode_schema.capnp:Node'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.'({VarDiscriminant,Var},
                            PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        file ->
            {1688871335100416,
             11,
             0,
             <<case Var of
                   undefined ->
                       0
               end:0/integer,
               0:96/integer,
               0:16/little-unsigned-integer,
               0:208/integer,
               0:384/integer>>,
             []};
        struct ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:704/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Node.struct'(Var,
                                                  PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (1 bsl 96)):704/little-unsigned-integer>>,
             ExtraData};
        enum ->
            if
                Var =/= undefined ->
                    DataLen = length(Var),
                    {FinalOffset,Data1,Extra1} =
                        lists:foldl(fun(Element,
                                        {Offset,DataAcc,ExtraAcc}) ->
                                           {562954248388608,
                                            3,
                                            ExtraLen,
                                            ThisBody,
                                            ThisExtra} =
                                               'encode_schema.capnp:Enumerant'(Element,
                                                                               Offset
                                                                               -
                                                                               3),
                                           {ExtraLen + Offset - 3,
                                            [DataAcc,ThisBody],
                                            [ExtraAcc|ThisExtra]}
                                    end,
                                    {DataLen * 3,
                                     [<<(DataLen bsl 2 + 562954248388608):64/unsigned-little-integer>>],
                                     []},
                                    Var),
                    FinalOffset = round(iolist_size(Extra1) / 8),
                    Ptr =
                        1 bor (0 + PtrOffsetWordsFromEnd0 bsl 2)
                        bor
                        (7 bsl 32)
                        bor
                        (DataLen * 3 bsl 35),
                    PtrOffsetWordsFromEnd1 =
                        PtrOffsetWordsFromEnd0 + 1 + DataLen * 3
                        +
                        FinalOffset;
                true ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {1688871335100416,
             11,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<0:96/integer,
               2:16/little-unsigned-integer,
               0:208/integer,
               0:192/integer,
               Ptr:64/little-unsigned-integer,
               0:128/integer>>,
             [Data1,Extra1]};
        interface ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:704/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Node.interface'(Var,
                                                     PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (3 bsl 96)):704/little-unsigned-integer>>,
             ExtraData};
        const ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:704/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Node.const'(Var,
                                                 PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (4 bsl 96)):704/little-unsigned-integer>>,
             ExtraData};
        annotation ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:704/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Node.annotation'(Var,
                                                      PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (5 bsl 96)):704/little-unsigned-integer>>,
             ExtraData}
    end.

'encode_schema.capnp:Node.NestedNode'(#'schema.capnp:Node.NestedNode'{id =
                                                                          Varid,
                                                                      name =
                                                                          Varname},
                                      PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varname);is_binary(Varname) ->
            Extra1 = <<>>,
            DataLenname = iolist_size(Varname) + 1,
            Data1 =
                [Varname,
                 <<0:8,
                   0:(- DataLenname band 7 * 8)/unsigned-little-integer>>],
            Ptrname =
                1 bor (PtrOffsetWordsFromEnd0 + 0 bsl 2) bor (2 bsl 32)
                bor
                (DataLenname bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenname + 7 bsr 3);
        Varname =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrname = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    {281479271677952,
     2,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<Varid:64/little-unsigned-integer,
       Ptrname:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Node.NestedNode'(undefined,
                                      _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.Parameter'(#'schema.capnp:Node.Parameter'{name =
                                                                        Varname},
                                     PtrOffsetWordsFromEnd0) ->
    if
        is_list(Varname);is_binary(Varname) ->
            Extra1 = <<>>,
            DataLenname = iolist_size(Varname) + 1,
            Data1 =
                [Varname,
                 <<0:8,
                   0:(- DataLenname band 7 * 8)/unsigned-little-integer>>],
            Ptrname =
                1 bor (PtrOffsetWordsFromEnd0 + 0 bsl 2) bor (2 bsl 32)
                bor
                (DataLenname bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + (DataLenname + 7 bsr 3);
        Varname =:= undefined ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrname = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    {281474976710656,
     1,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<Ptrname:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Node.Parameter'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.annotation'(#'schema.capnp:Node.annotation'{targetsGroup =
                                                                          VartargetsGroup,
                                                                      targetsUnion =
                                                                          VartargetsUnion,
                                                                      targetsField =
                                                                          VartargetsField,
                                                                      targetsStruct =
                                                                          VartargetsStruct,
                                                                      targetsEnumerant =
                                                                          VartargetsEnumerant,
                                                                      targetsEnum =
                                                                          VartargetsEnum,
                                                                      targetsConst =
                                                                          VartargetsConst,
                                                                      targetsFile =
                                                                          VartargetsFile,
                                                                      targetsAnnotation =
                                                                          VartargetsAnnotation,
                                                                      targetsParam =
                                                                          VartargetsParam,
                                                                      targetsMethod =
                                                                          VartargetsMethod,
                                                                      targetsInterface =
                                                                          VartargetsInterface,
                                                                      type =
                                                                          Vartype},
                                      PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrInttype,MainLentype,ExtraLentype,Data1,Extra1} =
        'encode_schema.capnp:Type'(Vartype, 0),
    Ptrtype =
        case ZeroOffsetPtrInttype of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 2 bsl 2 + ZeroOffsetPtrInttype
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLentype + ExtraLentype,
    {1688871335100416,
     11,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:112/integer,
       case VartargetsGroup of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsUnion of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsField of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsStruct of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsEnumerant of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsEnum of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsConst of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsFile of
           false ->
               0;
           true ->
               1
       end:1/integer,
       0:4/integer,
       case VartargetsAnnotation of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsParam of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsMethod of
           false ->
               0;
           true ->
               1
       end:1/integer,
       case VartargetsInterface of
           false ->
               0;
           true ->
               1
       end:1/integer,
       0:192/integer,
       0:192/integer,
       Ptrtype:64/little-unsigned-integer,
       0:128/integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Node.annotation'(undefined,
                                      _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.const'(#'schema.capnp:Node.const'{type =
                                                                Vartype,
                                                            value =
                                                                Varvalue},
                                 PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrInttype,MainLentype,ExtraLentype,Data1,Extra1} =
        'encode_schema.capnp:Type'(Vartype, 0),
    Ptrtype =
        case ZeroOffsetPtrInttype of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 2 bsl 2 + ZeroOffsetPtrInttype
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLentype + ExtraLentype,
    {ZeroOffsetPtrIntvalue,MainLenvalue,ExtraLenvalue,Data2,Extra2} =
        'encode_schema.capnp:Value'(Varvalue, 0),
    Ptrvalue =
        case ZeroOffsetPtrIntvalue of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd1 + 1 bsl 2 + ZeroOffsetPtrIntvalue
        end,
    PtrOffsetWordsFromEnd2 =
        PtrOffsetWordsFromEnd1 + MainLenvalue + ExtraLenvalue,
    {1688871335100416,
     11,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<0:320/integer,
       0:192/integer,
       Ptrtype:64/little-unsigned-integer,
       Ptrvalue:64/little-unsigned-integer,
       0:64/integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:Node.const'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.enum'(#'schema.capnp:Node.enum'{enumerants =
                                                              Varenumerants},
                                PtrOffsetWordsFromEnd0) ->
    if
        Varenumerants =/= undefined ->
            DataLenenumerants = length(Varenumerants),
            {FinalOffsetenumerants,Data1,Extra1} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {562954248388608,
                                    3,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Enumerant'(Element,
                                                                       Offset
                                                                       -
                                                                       3),
                                   {ExtraLen + Offset - 3,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenenumerants * 3,
                             [<<(DataLenenumerants bsl 2
                                 +
                                 562954248388608):64/unsigned-little-integer>>],
                             []},
                            Varenumerants),
            FinalOffsetenumerants = round(iolist_size(Extra1) / 8),
            Ptrenumerants =
                1 bor (2 + PtrOffsetWordsFromEnd0 bsl 2) bor (7 bsl 32)
                bor
                (DataLenenumerants * 3 bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + 1 + DataLenenumerants * 3
                +
                FinalOffsetenumerants;
        true ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrenumerants = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    {1688871335100416,
     11,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:320/integer,
       0:192/integer,
       Ptrenumerants:64/little-unsigned-integer,
       0:128/integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Node.enum'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.interface'(#'schema.capnp:Node.interface'{methods =
                                                                        Varmethods,
                                                                    superclasses =
                                                                        Varsuperclasses},
                                     PtrOffsetWordsFromEnd0) ->
    if
        Varmethods =/= undefined ->
            DataLenmethods = length(Varmethods),
            {FinalOffsetmethods,Data1,Extra1} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {1407387768455168,
                                    8,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Method'(Element,
                                                                    Offset
                                                                    -
                                                                    8),
                                   {ExtraLen + Offset - 8,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenmethods * 8,
                             [<<(DataLenmethods bsl 2 + 1407387768455168):64/unsigned-little-integer>>],
                             []},
                            Varmethods),
            FinalOffsetmethods = round(iolist_size(Extra1) / 8),
            Ptrmethods =
                1 bor (2 + PtrOffsetWordsFromEnd0 bsl 2) bor (7 bsl 32)
                bor
                (DataLenmethods * 8 bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + 1 + DataLenmethods * 8
                +
                FinalOffsetmethods;
        true ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrmethods = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    if
        Varsuperclasses =/= undefined ->
            DataLensuperclasses = length(Varsuperclasses),
            {FinalOffsetsuperclasses,Data2,Extra2} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {281479271677952,
                                    2,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Superclass'(Element,
                                                                        Offset
                                                                        -
                                                                        2),
                                   {ExtraLen + Offset - 2,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLensuperclasses * 2,
                             [<<(DataLensuperclasses bsl 2
                                 +
                                 281479271677952):64/unsigned-little-integer>>],
                             []},
                            Varsuperclasses),
            FinalOffsetsuperclasses = round(iolist_size(Extra2) / 8),
            Ptrsuperclasses =
                1 bor (1 + PtrOffsetWordsFromEnd1 bsl 2) bor (7 bsl 32)
                bor
                (DataLensuperclasses * 2 bsl 35),
            PtrOffsetWordsFromEnd2 =
                PtrOffsetWordsFromEnd1 + 1 + DataLensuperclasses * 2
                +
                FinalOffsetsuperclasses;
        true ->
            Extra2 = <<>>,
            Data2 = [],
            Ptrsuperclasses = 0,
            PtrOffsetWordsFromEnd2 = PtrOffsetWordsFromEnd1
    end,
    {1688871335100416,
     11,
     PtrOffsetWordsFromEnd2 - PtrOffsetWordsFromEnd0,
     <<0:320/integer,
       0:192/integer,
       Ptrmethods:64/little-unsigned-integer,
       Ptrsuperclasses:64/little-unsigned-integer,
       0:64/integer>>,
     [Data1,Extra1,Data2,Extra2]};
'encode_schema.capnp:Node.interface'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Node.struct'(#'schema.capnp:Node.struct'{dataWordCount =
                                                                  VardataWordCount,
                                                              pointerCount =
                                                                  VarpointerCount,
                                                              preferredListEncoding =
                                                                  VarpreferredListEncoding,
                                                              isGroup =
                                                                  VarisGroup,
                                                              discriminantCount =
                                                                  VardiscriminantCount,
                                                              discriminantOffset =
                                                                  VardiscriminantOffset,
                                                              fields =
                                                                  Varfields},
                                  PtrOffsetWordsFromEnd0) ->
    if
        Varfields =/= undefined ->
            DataLenfields = length(Varfields),
            {FinalOffsetfields,Data1,Extra1} =
                lists:foldl(fun(Element, {Offset,DataAcc,ExtraAcc}) ->
                                   {1125912791744512,
                                    7,
                                    ExtraLen,
                                    ThisBody,
                                    ThisExtra} =
                                       'encode_schema.capnp:Field'(Element,
                                                                   Offset
                                                                   -
                                                                   7),
                                   {ExtraLen + Offset - 7,
                                    [DataAcc,ThisBody],
                                    [ExtraAcc|ThisExtra]}
                            end,
                            {DataLenfields * 7,
                             [<<(DataLenfields bsl 2 + 1125912791744512):64/unsigned-little-integer>>],
                             []},
                            Varfields),
            FinalOffsetfields = round(iolist_size(Extra1) / 8),
            Ptrfields =
                1 bor (2 + PtrOffsetWordsFromEnd0 bsl 2) bor (7 bsl 32)
                bor
                (DataLenfields * 7 bsl 35),
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + 1 + DataLenfields * 7
                +
                FinalOffsetfields;
        true ->
            Extra1 = <<>>,
            Data1 = [],
            Ptrfields = 0,
            PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
    end,
    {1688871335100416,
     11,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:112/integer,
       VardataWordCount:16/little-unsigned-integer,
       0:64/integer,
       VarpointerCount:16/little-unsigned-integer,
       case VarpreferredListEncoding of
           empty ->
               0;
           bit ->
               1;
           byte ->
               2;
           twoBytes ->
               3;
           fourBytes ->
               4;
           eightBytes ->
               5;
           pointer ->
               6;
           inlineComposite ->
               7
       end:16/little-unsigned-integer,
       0:7/integer,
       case VarisGroup of
           false ->
               0;
           true ->
               1
       end:1/integer,
       0:8/integer,
       VardiscriminantCount:16/little-unsigned-integer,
       VardiscriminantOffset:32/little-unsigned-integer,
       0:32/integer,
       0:192/integer,
       Ptrfields:64/little-unsigned-integer,
       0:128/integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Node.struct'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Superclass'(#'schema.capnp:Superclass'{id = Varid,
                                                            brand =
                                                                Varbrand},
                                 PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrIntbrand,MainLenbrand,ExtraLenbrand,Data1,Extra1} =
        'encode_schema.capnp:Brand'(Varbrand, 0),
    Ptrbrand =
        case ZeroOffsetPtrIntbrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 0 bsl 2 + ZeroOffsetPtrIntbrand
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLenbrand + ExtraLenbrand,
    {281479271677952,
     2,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<Varid:64/little-unsigned-integer,
       Ptrbrand:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Superclass'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Type'({VarDiscriminant,Var},
                           PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        void ->
            {281487861612544,
             4,
             0,
             <<0:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        bool ->
            {281487861612544,
             4,
             0,
             <<1:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        int8 ->
            {281487861612544,
             4,
             0,
             <<2:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        int16 ->
            {281487861612544,
             4,
             0,
             <<3:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        int32 ->
            {281487861612544,
             4,
             0,
             <<4:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        int64 ->
            {281487861612544,
             4,
             0,
             <<5:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        uint8 ->
            {281487861612544,
             4,
             0,
             <<6:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        uint16 ->
            {281487861612544,
             4,
             0,
             <<7:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        uint32 ->
            {281487861612544,
             4,
             0,
             <<8:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        uint64 ->
            {281487861612544,
             4,
             0,
             <<9:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        float32 ->
            {281487861612544,
             4,
             0,
             <<10:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        float64 ->
            {281487861612544,
             4,
             0,
             <<11:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        text ->
            {281487861612544,
             4,
             0,
             <<12:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        data ->
            {281487861612544,
             4,
             0,
             <<13:16/little-unsigned-integer,0:176/integer,0:64/integer>>,
             []};
        list ->
            {ZeroOffsetPtrInt,MainLen,ExtraLen,Data1,Extra1} =
                'encode_schema.capnp:Type'(Var, 0),
            Ptr =
                case ZeroOffsetPtrInt of
                    0 ->
                        0;
                    _ ->
                        PtrOffsetWordsFromEnd0 + 0 bsl 2
                        +
                        ZeroOffsetPtrInt
                end,
            PtrOffsetWordsFromEnd1 =
                PtrOffsetWordsFromEnd0 + MainLen + ExtraLen,
            {281487861612544,
             4,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<14:16/little-unsigned-integer,
               0:176/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]};
        enum ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:256/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Type.enum'(Var,
                                                PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (15 bsl 0)):256/little-unsigned-integer>>,
             ExtraData};
        struct ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:256/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Type.struct'(Var,
                                                  PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (16 bsl 0)):256/little-unsigned-integer>>,
             ExtraData};
        interface ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:256/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Type.interface'(Var,
                                                     PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (17 bsl 0)):256/little-unsigned-integer>>,
             ExtraData};
        anyPointer ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:256/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Type.anyPointer'(Var,
                                                      PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (18 bsl 0)):256/little-unsigned-integer>>,
             ExtraData}
    end.

'encode_schema.capnp:Type.anyPointer'({VarDiscriminant,Var},
                                      PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        unconstrained ->
            {281487861612544,
             4,
             0,
             <<case Var of
                   undefined ->
                       0
               end:0/integer,
               0:64/integer,
               0:16/little-unsigned-integer,
               0:112/integer,
               0:64/integer>>,
             []};
        parameter ->
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<DataInt:256/little-unsigned-integer>>,
             ExtraData} =
                'encode_schema.capnp:Type.anyPointer.parameter'(Var,
                                                                PtrOffsetWordsFromEnd0),
            {ZeroOffsetPtrInt,
             MainLen,
             ExtraLen,
             <<(DataInt bor (1 bsl 64)):256/little-unsigned-integer>>,
             ExtraData};
        implicitMethodParameter ->
            {281487861612544,
             4,
             0,
             <<0:64/integer,
               2:16/little-unsigned-integer,
               Var:16/little-unsigned-integer,
               0:96/integer,
               0:64/integer>>,
             []}
    end.

'encode_schema.capnp:Type.anyPointer.implicitMethodParameter'(#'schema.capnp:Type.anyPointer.implicitMethodParameter'{parameterIndex =
                                                                                                                          VarparameterIndex},
                                                              PtrOffsetWordsFromEnd0) ->
    {281487861612544,
     4,
     PtrOffsetWordsFromEnd0 - PtrOffsetWordsFromEnd0,
     <<0:80/integer,
       VarparameterIndex:16/little-unsigned-integer,
       0:96/integer,
       0:64/integer>>,
     []};
'encode_schema.capnp:Type.anyPointer.implicitMethodParameter'(undefined,
                                                              _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Type.anyPointer.parameter'(#'schema.capnp:Type.anyPointer.parameter'{parameterIndex =
                                                                                              VarparameterIndex,
                                                                                          scopeId =
                                                                                              VarscopeId},
                                                PtrOffsetWordsFromEnd0) ->
    {281487861612544,
     4,
     PtrOffsetWordsFromEnd0 - PtrOffsetWordsFromEnd0,
     <<0:80/integer,
       VarparameterIndex:16/little-unsigned-integer,
       0:32/integer,
       VarscopeId:64/little-unsigned-integer,
       0:64/integer>>,
     []};
'encode_schema.capnp:Type.anyPointer.parameter'(undefined,
                                                _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Type.enum'(#'schema.capnp:Type.enum'{typeId =
                                                              VartypeId,
                                                          brand =
                                                              Varbrand},
                                PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrIntbrand,MainLenbrand,ExtraLenbrand,Data1,Extra1} =
        'encode_schema.capnp:Brand'(Varbrand, 0),
    Ptrbrand =
        case ZeroOffsetPtrIntbrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 0 bsl 2 + ZeroOffsetPtrIntbrand
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLenbrand + ExtraLenbrand,
    {281487861612544,
     4,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:64/integer,
       VartypeId:64/little-unsigned-integer,
       0:64/integer,
       Ptrbrand:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Type.enum'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Type.interface'(#'schema.capnp:Type.interface'{typeId =
                                                                        VartypeId,
                                                                    brand =
                                                                        Varbrand},
                                     PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrIntbrand,MainLenbrand,ExtraLenbrand,Data1,Extra1} =
        'encode_schema.capnp:Brand'(Varbrand, 0),
    Ptrbrand =
        case ZeroOffsetPtrIntbrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 0 bsl 2 + ZeroOffsetPtrIntbrand
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLenbrand + ExtraLenbrand,
    {281487861612544,
     4,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:64/integer,
       VartypeId:64/little-unsigned-integer,
       0:64/integer,
       Ptrbrand:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Type.interface'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Type.list'(#'schema.capnp:Type.list'{elementType =
                                                              VarelementType},
                                PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrIntelementType,
     MainLenelementType,
     ExtraLenelementType,
     Data1,
     Extra1} =
        'encode_schema.capnp:Type'(VarelementType, 0),
    PtrelementType =
        case ZeroOffsetPtrIntelementType of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 0 bsl 2
                +
                ZeroOffsetPtrIntelementType
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLenelementType
        +
        ExtraLenelementType,
    {281487861612544,
     4,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:192/integer,PtrelementType:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Type.list'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Type.struct'(#'schema.capnp:Type.struct'{typeId =
                                                                  VartypeId,
                                                              brand =
                                                                  Varbrand},
                                  PtrOffsetWordsFromEnd0) ->
    {ZeroOffsetPtrIntbrand,MainLenbrand,ExtraLenbrand,Data1,Extra1} =
        'encode_schema.capnp:Brand'(Varbrand, 0),
    Ptrbrand =
        case ZeroOffsetPtrIntbrand of
            0 ->
                0;
            _ ->
                PtrOffsetWordsFromEnd0 + 0 bsl 2 + ZeroOffsetPtrIntbrand
        end,
    PtrOffsetWordsFromEnd1 =
        PtrOffsetWordsFromEnd0 + MainLenbrand + ExtraLenbrand,
    {281487861612544,
     4,
     PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
     <<0:64/integer,
       VartypeId:64/little-unsigned-integer,
       0:64/integer,
       Ptrbrand:64/little-unsigned-integer>>,
     [Data1,Extra1]};
'encode_schema.capnp:Type.struct'(undefined, _PtrOffsetWordsFromEnd0) ->
    {0,0,0,[],[]}.

'encode_schema.capnp:Value'({VarDiscriminant,Var},
                            PtrOffsetWordsFromEnd0) ->
    case VarDiscriminant of
        void ->
            {281483566645248,
             3,
             0,
             <<0:16/little-unsigned-integer,0:112/integer,0:64/integer>>,
             []};
        bool ->
            {281483566645248,
             3,
             0,
             <<1:16/little-unsigned-integer,
               0:7/integer,
               case Var of
                   false ->
                       0;
                   true ->
                       1
               end:1/integer,
               0:104/integer,
               0:64/integer>>,
             []};
        int8 ->
            {281483566645248,
             3,
             0,
             <<2:16/little-unsigned-integer,
               Var:8/little-signed-integer,
               0:104/integer,
               0:64/integer>>,
             []};
        int16 ->
            {281483566645248,
             3,
             0,
             <<3:16/little-unsigned-integer,
               Var:16/little-signed-integer,
               0:96/integer,
               0:64/integer>>,
             []};
        int32 ->
            {281483566645248,
             3,
             0,
             <<4:16/little-unsigned-integer,
               0:16/integer,
               Var:32/little-signed-integer,
               0:64/integer,
               0:64/integer>>,
             []};
        int64 ->
            {281483566645248,
             3,
             0,
             <<5:16/little-unsigned-integer,
               0:48/integer,
               Var:64/little-signed-integer,
               0:64/integer>>,
             []};
        uint8 ->
            {281483566645248,
             3,
             0,
             <<6:16/little-unsigned-integer,
               Var:8/little-unsigned-integer,
               0:104/integer,
               0:64/integer>>,
             []};
        uint16 ->
            {281483566645248,
             3,
             0,
             <<7:16/little-unsigned-integer,
               Var:16/little-unsigned-integer,
               0:96/integer,
               0:64/integer>>,
             []};
        uint32 ->
            {281483566645248,
             3,
             0,
             <<8:16/little-unsigned-integer,
               0:16/integer,
               Var:32/little-unsigned-integer,
               0:64/integer,
               0:64/integer>>,
             []};
        uint64 ->
            {281483566645248,
             3,
             0,
             <<9:16/little-unsigned-integer,
               0:48/integer,
               Var:64/little-unsigned-integer,
               0:64/integer>>,
             []};
        float32 ->
            {281483566645248,
             3,
             0,
             <<10:16/little-unsigned-integer,
               0:16/integer,
               Var:32/little-float,
               0:64/integer,
               0:64/integer>>,
             []};
        float64 ->
            {281483566645248,
             3,
             0,
             <<11:16/little-unsigned-integer,
               0:48/integer,
               Var:64/little-float,
               0:64/integer>>,
             []};
        text ->
            if
                is_list(Var);is_binary(Var) ->
                    Extra1 = <<>>,
                    DataLen = iolist_size(Var) + 1,
                    Data1 =
                        [Var,
                         <<0:8,
                           0:(- DataLen band 7 * 8)/unsigned-little-integer>>],
                    Ptr =
                        1 bor (PtrOffsetWordsFromEnd0 + 0 bsl 2)
                        bor
                        (2 bsl 32)
                        bor
                        (DataLen bsl 35),
                    PtrOffsetWordsFromEnd1 =
                        PtrOffsetWordsFromEnd0 + (DataLen + 7 bsr 3);
                Var =:= undefined ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {281483566645248,
             3,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<12:16/little-unsigned-integer,
               0:112/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]};
        data ->
            if
                is_list(Var);is_binary(Var) ->
                    Extra1 = <<>>,
                    DataLen = iolist_size(Var),
                    Data1 =
                        [Var,
                         <<0:(- DataLen band 7 * 8)/unsigned-little-integer>>],
                    Ptr =
                        1 bor (PtrOffsetWordsFromEnd0 + 0 bsl 2)
                        bor
                        (2 bsl 32)
                        bor
                        (DataLen bsl 35),
                    PtrOffsetWordsFromEnd1 =
                        PtrOffsetWordsFromEnd0 + (DataLen + 7 bsr 3);
                Var =:= undefined ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {281483566645248,
             3,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<13:16/little-unsigned-integer,
               0:112/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]};
        list ->
            if
                Var =:= undefined ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {281483566645248,
             3,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<14:16/little-unsigned-integer,
               0:112/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]};
        enum ->
            {281483566645248,
             3,
             0,
             <<15:16/little-unsigned-integer,
               Var:16/little-unsigned-integer,
               0:96/integer,
               0:64/integer>>,
             []};
        struct ->
            if
                Var =:= undefined ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {281483566645248,
             3,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<16:16/little-unsigned-integer,
               0:112/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]};
        interface ->
            {281483566645248,
             3,
             0,
             <<17:16/little-unsigned-integer,0:112/integer,0:64/integer>>,
             []};
        anyPointer ->
            if
                Var =:= undefined ->
                    Extra1 = <<>>,
                    Data1 = [],
                    Ptr = 0,
                    PtrOffsetWordsFromEnd1 = PtrOffsetWordsFromEnd0
            end,
            {281483566645248,
             3,
             PtrOffsetWordsFromEnd1 - PtrOffsetWordsFromEnd0,
             <<18:16/little-unsigned-integer,
               0:112/integer,
               Ptr:64/little-unsigned-integer>>,
             [Data1,Extra1]}
    end.

'envelope_schema.capnp:Annotation'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Annotation'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Brand'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Brand'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Brand.Binding'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Brand.Binding'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Brand.Scope'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Brand.Scope'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:CodeGeneratorRequest'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:CodeGeneratorRequest'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:CodeGeneratorRequest.RequestedFile'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:CodeGeneratorRequest.RequestedFile'(Input,
                                                                 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(Input,
                                                                        0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Enumerant'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Enumerant'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Field'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Field'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Method'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Method'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Node'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Node'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Node.NestedNode'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Node.NestedNode'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Node.Parameter'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Node.Parameter'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Superclass'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Superclass'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Type'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Type'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

'envelope_schema.capnp:Value'(Input) ->
    {ZeroOffsetPtrInt,MainDataLen,ExtraDataLen,MainData,ExtraData} =
        'encode_schema.capnp:Value'(Input, 0),
    list_to_binary([<<0:32/unsigned-little-integer,
                      (1 + MainDataLen + ExtraDataLen):32/unsigned-little-integer,
                      ZeroOffsetPtrInt:64/unsigned-little-integer>>,
                    MainData,
                    ExtraData]).

follow_data_pointer(0, _) ->
    undefined;
follow_data_pointer(PointerInt, MessageRef)
    when
        PointerInt band 3 =:= 1
        andalso
        (PointerInt bsr 32) band 7 =:= 2 ->
    PointerOffset = (PointerInt bsr 2) band (1 bsl 30 - 1) + 1,
    Offset = MessageRef#message_ref.current_offset + PointerOffset,
    SkipBits = Offset bsl 6,
    Length = PointerInt bsr 35 - 0,
    MessageBits = Length bsl 3,
    <<_:SkipBits,ListData:MessageBits/bitstring,_/bitstring>> =
        MessageRef#message_ref.current_segment,
    ListData.

follow_struct_pointer(DecodeFun, 0, MessageRef) ->
    undefined;
follow_struct_pointer(DecodeFun, PointerInt, MessageRef)
    when PointerInt band 3 == 0 ->
    PointerOffset = (PointerInt bsr 2) band (1 bsl 30 - 1) + 1,
    NewOffset = MessageRef#message_ref.current_offset + PointerOffset,
    NewMessageRef = MessageRef#message_ref{current_offset = NewOffset},
    DWords = (PointerInt bsr 32) band (1 bsl 16 - 1),
    PWords = (PointerInt bsr 48) band (1 bsl 16 - 1),
    SkipBits = NewOffset bsl 6,
    Bits = DWords + PWords bsl 6,
    <<_:SkipBits,Binary:Bits/bitstring,_/binary>> =
        MessageRef#message_ref.current_segment,
    DecodeFun(Binary, NewMessageRef).

follow_tagged_struct_list_pointer(DecodeFun, 0, MessageRef) ->
    undefined;
follow_tagged_struct_list_pointer(DecodeFun, PointerInt, MessageRef)
    when PointerInt band 3 == 1 ->
    PointerOffset = (PointerInt bsr 2) band (1 bsl 30 - 1) + 1,
    NewOffset = MessageRef#message_ref.current_offset + PointerOffset,
    SkipBits = NewOffset bsl 6,
    <<_:SkipBits,Tag:64/little-unsigned-integer,Rest/binary>> =
        MessageRef#message_ref.current_segment,
    Length = (Tag bsr 2) band (1 bsl 30 - 1),
    DWords = (Tag bsr 32) band (1 bsl 16 - 1),
    PWords = (Tag bsr 48) band (1 bsl 16 - 1),
    decode_struct_list(DecodeFun,
                       Length,
                       DWords,
                       PWords,
                       MessageRef#message_ref{current_offset =
                                                  NewOffset + 1}).

follow_text_pointer(0, _) ->
    undefined;
follow_text_pointer(PointerInt, MessageRef)
    when
        PointerInt band 3 =:= 1
        andalso
        (PointerInt bsr 32) band 7 =:= 2 ->
    PointerOffset = (PointerInt bsr 2) band (1 bsl 30 - 1) + 1,
    Offset = MessageRef#message_ref.current_offset + PointerOffset,
    SkipBits = Offset bsl 6,
    Length = PointerInt bsr 35 - 1,
    MessageBits = Length bsl 3,
    <<_:SkipBits,ListData:MessageBits/bitstring,_/bitstring>> =
        MessageRef#message_ref.current_segment,
    ListData.

'internal_decode_schema.capnp:Annotation'(All =
                                              <<Varid:64/little-unsigned-integer,
                                                Varvalue:64/little-unsigned-integer,
                                                Varbrand:64/little-unsigned-integer>>,
                                          MessageRef) ->
    #'schema.capnp:Annotation'{id = Varid,
                               value =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Value'/2,
                                                         Varvalue,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    1
                                                                                    +
                                                                                    0}),
                               brand =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                         Varbrand,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    1
                                                                                    +
                                                                                    1})}.

'internal_decode_schema.capnp:Brand'(All =
                                         <<Varscopes:64/little-unsigned-integer>>,
                                     MessageRef) ->
    #'schema.capnp:Brand'{scopes =
                              follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Brand.Scope'/2,
                                                                Varscopes,
                                                                MessageRef#message_ref{current_offset =
                                                                                           MessageRef#message_ref.current_offset
                                                                                           +
                                                                                           0
                                                                                           +
                                                                                           0})}.

'internal_decode_schema.capnp:Brand.Binding'(Body, MessageRef) ->
    <<_:0,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {unbound,undefined};
        1 ->
            <<_:64,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {type,
             follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                                   Var,
                                   MessageRef#message_ref{current_offset =
                                                              MessageRef#message_ref.current_offset
                                                              +
                                                              1
                                                              +
                                                              0})}
    end.

'internal_decode_schema.capnp:Brand.Scope'(All =
                                               <<VarscopeId:64/little-unsigned-integer,
                                                 _:64/integer,
                                                 _:64/integer>>,
                                           MessageRef) ->
    #'schema.capnp:Brand.Scope'{scopeId = VarscopeId,
                                '' =
                                    'internal_decode_schema.capnp:Brand.Scope.'(All,
                                                                                MessageRef)}.

'internal_decode_schema.capnp:Brand.Scope.'(Body, MessageRef) ->
    <<_:64,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {bind,
             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Brand.Binding'/2,
                                               Var,
                                               MessageRef#message_ref{current_offset =
                                                                          MessageRef#message_ref.current_offset
                                                                          +
                                                                          2
                                                                          +
                                                                          0})};
        1 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {inherit,undefined}
    end.

'internal_decode_schema.capnp:CodeGeneratorRequest'(All =
                                                        <<Varnodes:64/little-unsigned-integer,
                                                          VarrequestedFiles:64/little-unsigned-integer>>,
                                                    MessageRef) ->
    #'schema.capnp:CodeGeneratorRequest'{nodes =
                                             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Node'/2,
                                                                               Varnodes,
                                                                               MessageRef#message_ref{current_offset =
                                                                                                          MessageRef#message_ref.current_offset
                                                                                                          +
                                                                                                          0
                                                                                                          +
                                                                                                          0}),
                                         requestedFiles =
                                             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:CodeGeneratorRequest.RequestedFile'/2,
                                                                               VarrequestedFiles,
                                                                               MessageRef#message_ref{current_offset =
                                                                                                          MessageRef#message_ref.current_offset
                                                                                                          +
                                                                                                          0
                                                                                                          +
                                                                                                          1})}.

'internal_decode_schema.capnp:CodeGeneratorRequest.RequestedFile'(All =
                                                                      <<Varid:64/little-unsigned-integer,
                                                                        Varfilename:64/little-unsigned-integer,
                                                                        Varimports:64/little-unsigned-integer>>,
                                                                  MessageRef) ->
    #'schema.capnp:CodeGeneratorRequest.RequestedFile'{id = Varid,
                                                       filename =
                                                           follow_text_pointer(Varfilename,
                                                                               MessageRef#message_ref{current_offset =
                                                                                                          MessageRef#message_ref.current_offset
                                                                                                          +
                                                                                                          1
                                                                                                          +
                                                                                                          0}),
                                                       imports =
                                                           follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'/2,
                                                                                             Varimports,
                                                                                             MessageRef#message_ref{current_offset =
                                                                                                                        MessageRef#message_ref.current_offset
                                                                                                                        +
                                                                                                                        1
                                                                                                                        +
                                                                                                                        1})}.

'internal_decode_schema.capnp:CodeGeneratorRequest.RequestedFile.Import'(All =
                                                                             <<Varid:64/little-unsigned-integer,
                                                                               Varname:64/little-unsigned-integer>>,
                                                                         MessageRef) ->
    #'schema.capnp:CodeGeneratorRequest.RequestedFile.Import'{id = Varid,
                                                              name =
                                                                  follow_text_pointer(Varname,
                                                                                      MessageRef#message_ref{current_offset =
                                                                                                                 MessageRef#message_ref.current_offset
                                                                                                                 +
                                                                                                                 1
                                                                                                                 +
                                                                                                                 0})}.

'internal_decode_schema.capnp:Enumerant'(All =
                                             <<VarcodeOrder:16/little-unsigned-integer,
                                               _:48/integer,
                                               Varname:64/little-unsigned-integer,
                                               Varannotations:64/little-unsigned-integer>>,
                                         MessageRef) ->
    #'schema.capnp:Enumerant'{codeOrder = VarcodeOrder,
                              name =
                                  follow_text_pointer(Varname,
                                                      MessageRef#message_ref{current_offset =
                                                                                 MessageRef#message_ref.current_offset
                                                                                 +
                                                                                 1
                                                                                 +
                                                                                 0}),
                              annotations =
                                  follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Annotation'/2,
                                                                    Varannotations,
                                                                    MessageRef#message_ref{current_offset =
                                                                                               MessageRef#message_ref.current_offset
                                                                                               +
                                                                                               1
                                                                                               +
                                                                                               1})}.

'internal_decode_schema.capnp:Field'(All =
                                         <<VarcodeOrder:16/little-unsigned-integer,
                                           VardiscriminantValue:16/little-unsigned-integer,
                                           _:160/integer,
                                           Varname:64/little-unsigned-integer,
                                           Varannotations:64/little-unsigned-integer,
                                           _:128/integer>>,
                                     MessageRef) ->
    #'schema.capnp:Field'{codeOrder = VarcodeOrder,
                          discriminantValue =
                              VardiscriminantValue bxor 65535,
                          name =
                              follow_text_pointer(Varname,
                                                  MessageRef#message_ref{current_offset =
                                                                             MessageRef#message_ref.current_offset
                                                                             +
                                                                             3
                                                                             +
                                                                             0}),
                          annotations =
                              follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Annotation'/2,
                                                                Varannotations,
                                                                MessageRef#message_ref{current_offset =
                                                                                           MessageRef#message_ref.current_offset
                                                                                           +
                                                                                           3
                                                                                           +
                                                                                           1}),
                          '' =
                              'internal_decode_schema.capnp:Field.'(All,
                                                                    MessageRef),
                          ordinal =
                              'internal_decode_schema.capnp:Field.ordinal'(All,
                                                                           MessageRef)}.

'internal_decode_schema.capnp:Field.'(Body, MessageRef) ->
    <<_:64,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            {slot,
             'internal_decode_schema.capnp:Field.slot'(Body, MessageRef)};
        1 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {group,Var}
    end.

'internal_decode_schema.capnp:Field.group'(All =
                                               <<_:128/integer,
                                                 VartypeId:64/little-unsigned-integer,
                                                 _:256/integer>>,
                                           MessageRef) ->
    #'schema.capnp:Field.group'{typeId = VartypeId}.

'internal_decode_schema.capnp:Field.ordinal'(Body, MessageRef) ->
    <<_:80,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {implicit,undefined};
        1 ->
            <<_:96,Var:16/little-unsigned-integer,_/bitstring>> = Body,
            {explicit,Var}
    end.

'internal_decode_schema.capnp:Field.slot'(All =
                                              <<_:32/integer,
                                                Varoffset:32/little-unsigned-integer,
                                                _:71/integer,
                                                VarhadExplicitDefault:1/integer,
                                                _:56/integer,
                                                _:128/integer,
                                                Vartype:64/little-unsigned-integer,
                                                VardefaultValue:64/little-unsigned-integer>>,
                                          MessageRef) ->
    #'schema.capnp:Field.slot'{offset = Varoffset,
                               hadExplicitDefault =
                                   case VarhadExplicitDefault of
                                       0 ->
                                           false;
                                       1 ->
                                           true
                                   end,
                               type =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                                                         Vartype,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    3
                                                                                    +
                                                                                    2}),
                               defaultValue =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Value'/2,
                                                         VardefaultValue,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    3
                                                                                    +
                                                                                    3})}.

'internal_decode_schema.capnp:Method'(All =
                                          <<VarcodeOrder:16/little-unsigned-integer,
                                            _:48/integer,
                                            VarparamStructType:64/little-unsigned-integer,
                                            VarresultStructType:64/little-unsigned-integer,
                                            Varname:64/little-unsigned-integer,
                                            Varannotations:64/little-unsigned-integer,
                                            VarparamBrand:64/little-unsigned-integer,
                                            VarresultBrand:64/little-unsigned-integer,
                                            VarimplicitParameters:64/little-unsigned-integer>>,
                                      MessageRef) ->
    #'schema.capnp:Method'{codeOrder = VarcodeOrder,
                           paramStructType = VarparamStructType,
                           resultStructType = VarresultStructType,
                           name =
                               follow_text_pointer(Varname,
                                                   MessageRef#message_ref{current_offset =
                                                                              MessageRef#message_ref.current_offset
                                                                              +
                                                                              3
                                                                              +
                                                                              0}),
                           annotations =
                               follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Annotation'/2,
                                                                 Varannotations,
                                                                 MessageRef#message_ref{current_offset =
                                                                                            MessageRef#message_ref.current_offset
                                                                                            +
                                                                                            3
                                                                                            +
                                                                                            1}),
                           paramBrand =
                               follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                     VarparamBrand,
                                                     MessageRef#message_ref{current_offset =
                                                                                MessageRef#message_ref.current_offset
                                                                                +
                                                                                3
                                                                                +
                                                                                2}),
                           resultBrand =
                               follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                     VarresultBrand,
                                                     MessageRef#message_ref{current_offset =
                                                                                MessageRef#message_ref.current_offset
                                                                                +
                                                                                3
                                                                                +
                                                                                3}),
                           implicitParameters =
                               follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Node.Parameter'/2,
                                                                 VarimplicitParameters,
                                                                 MessageRef#message_ref{current_offset =
                                                                                            MessageRef#message_ref.current_offset
                                                                                            +
                                                                                            3
                                                                                            +
                                                                                            4})}.

'internal_decode_schema.capnp:Node'(All =
                                        <<Varid:64/little-unsigned-integer,
                                          VardisplayNamePrefixLength:32/little-unsigned-integer,
                                          _:32/integer,
                                          VarscopeId:64/little-unsigned-integer,
                                          _:103/integer,
                                          VarisGeneric:1/integer,
                                          _:24/integer,
                                          VardisplayName:64/little-unsigned-integer,
                                          VarnestedNodes:64/little-unsigned-integer,
                                          Varannotations:64/little-unsigned-integer,
                                          _:128/integer,
                                          Varparameters:64/little-unsigned-integer>>,
                                    MessageRef) ->
    #'schema.capnp:Node'{id = Varid,
                         displayNamePrefixLength =
                             VardisplayNamePrefixLength,
                         scopeId = VarscopeId,
                         isGeneric =
                             case VarisGeneric of
                                 0 ->
                                     false;
                                 1 ->
                                     true
                             end,
                         displayName =
                             follow_text_pointer(VardisplayName,
                                                 MessageRef#message_ref{current_offset =
                                                                            MessageRef#message_ref.current_offset
                                                                            +
                                                                            5
                                                                            +
                                                                            0}),
                         nestedNodes =
                             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Node.NestedNode'/2,
                                                               VarnestedNodes,
                                                               MessageRef#message_ref{current_offset =
                                                                                          MessageRef#message_ref.current_offset
                                                                                          +
                                                                                          5
                                                                                          +
                                                                                          1}),
                         annotations =
                             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Annotation'/2,
                                                               Varannotations,
                                                               MessageRef#message_ref{current_offset =
                                                                                          MessageRef#message_ref.current_offset
                                                                                          +
                                                                                          5
                                                                                          +
                                                                                          2}),
                         parameters =
                             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Node.Parameter'/2,
                                                               Varparameters,
                                                               MessageRef#message_ref{current_offset =
                                                                                          MessageRef#message_ref.current_offset
                                                                                          +
                                                                                          5
                                                                                          +
                                                                                          5}),
                         '' =
                             'internal_decode_schema.capnp:Node.'(All,
                                                                  MessageRef)}.

'internal_decode_schema.capnp:Node.'(Body, MessageRef) ->
    <<_:96,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {file,undefined};
        1 ->
            {struct,
             'internal_decode_schema.capnp:Node.struct'(Body,
                                                        MessageRef)};
        2 ->
            <<_:512,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {enum,
             follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Enumerant'/2,
                                               Var,
                                               MessageRef#message_ref{current_offset =
                                                                          MessageRef#message_ref.current_offset
                                                                          +
                                                                          5
                                                                          +
                                                                          3})};
        3 ->
            {interface,
             'internal_decode_schema.capnp:Node.interface'(Body,
                                                           MessageRef)};
        4 ->
            {const,
             'internal_decode_schema.capnp:Node.const'(Body, MessageRef)};
        5 ->
            {annotation,
             'internal_decode_schema.capnp:Node.annotation'(Body,
                                                            MessageRef)}
    end.

'internal_decode_schema.capnp:Node.NestedNode'(All =
                                                   <<Varid:64/little-unsigned-integer,
                                                     Varname:64/little-unsigned-integer>>,
                                               MessageRef) ->
    #'schema.capnp:Node.NestedNode'{id = Varid,
                                    name =
                                        follow_text_pointer(Varname,
                                                            MessageRef#message_ref{current_offset =
                                                                                       MessageRef#message_ref.current_offset
                                                                                       +
                                                                                       1
                                                                                       +
                                                                                       0})}.

'internal_decode_schema.capnp:Node.Parameter'(All =
                                                  <<Varname:64/little-unsigned-integer>>,
                                              MessageRef) ->
    #'schema.capnp:Node.Parameter'{name =
                                       follow_text_pointer(Varname,
                                                           MessageRef#message_ref{current_offset =
                                                                                      MessageRef#message_ref.current_offset
                                                                                      +
                                                                                      0
                                                                                      +
                                                                                      0})}.

'internal_decode_schema.capnp:Node.annotation'(All =
                                                   <<_:112/integer,
                                                     VartargetsGroup:1/integer,
                                                     VartargetsUnion:1/integer,
                                                     VartargetsField:1/integer,
                                                     VartargetsStruct:1/integer,
                                                     VartargetsEnumerant:1/integer,
                                                     VartargetsEnum:1/integer,
                                                     VartargetsConst:1/integer,
                                                     VartargetsFile:1/integer,
                                                     _:4/integer,
                                                     VartargetsAnnotation:1/integer,
                                                     VartargetsParam:1/integer,
                                                     VartargetsMethod:1/integer,
                                                     VartargetsInterface:1/integer,
                                                     _:192/integer,
                                                     _:192/integer,
                                                     Vartype:64/little-unsigned-integer,
                                                     _:128/integer>>,
                                               MessageRef) ->
    #'schema.capnp:Node.annotation'{targetsGroup =
                                        case VartargetsGroup of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsUnion =
                                        case VartargetsUnion of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsField =
                                        case VartargetsField of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsStruct =
                                        case VartargetsStruct of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsEnumerant =
                                        case VartargetsEnumerant of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsEnum =
                                        case VartargetsEnum of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsConst =
                                        case VartargetsConst of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsFile =
                                        case VartargetsFile of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsAnnotation =
                                        case VartargetsAnnotation of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsParam =
                                        case VartargetsParam of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsMethod =
                                        case VartargetsMethod of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    targetsInterface =
                                        case VartargetsInterface of
                                            0 ->
                                                false;
                                            1 ->
                                                true
                                        end,
                                    type =
                                        follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                                                              Vartype,
                                                              MessageRef#message_ref{current_offset =
                                                                                         MessageRef#message_ref.current_offset
                                                                                         +
                                                                                         5
                                                                                         +
                                                                                         3})}.

'internal_decode_schema.capnp:Node.const'(All =
                                              <<_:320/integer,
                                                _:192/integer,
                                                Vartype:64/little-unsigned-integer,
                                                Varvalue:64/little-unsigned-integer,
                                                _:64/integer>>,
                                          MessageRef) ->
    #'schema.capnp:Node.const'{type =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                                                         Vartype,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    5
                                                                                    +
                                                                                    3}),
                               value =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Value'/2,
                                                         Varvalue,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    5
                                                                                    +
                                                                                    4})}.

'internal_decode_schema.capnp:Node.enum'(All =
                                             <<_:320/integer,
                                               _:192/integer,
                                               Varenumerants:64/little-unsigned-integer,
                                               _:128/integer>>,
                                         MessageRef) ->
    #'schema.capnp:Node.enum'{enumerants =
                                  follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Enumerant'/2,
                                                                    Varenumerants,
                                                                    MessageRef#message_ref{current_offset =
                                                                                               MessageRef#message_ref.current_offset
                                                                                               +
                                                                                               5
                                                                                               +
                                                                                               3})}.

'internal_decode_schema.capnp:Node.interface'(All =
                                                  <<_:320/integer,
                                                    _:192/integer,
                                                    Varmethods:64/little-unsigned-integer,
                                                    Varsuperclasses:64/little-unsigned-integer,
                                                    _:64/integer>>,
                                              MessageRef) ->
    #'schema.capnp:Node.interface'{methods =
                                       follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Method'/2,
                                                                         Varmethods,
                                                                         MessageRef#message_ref{current_offset =
                                                                                                    MessageRef#message_ref.current_offset
                                                                                                    +
                                                                                                    5
                                                                                                    +
                                                                                                    3}),
                                   superclasses =
                                       follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Superclass'/2,
                                                                         Varsuperclasses,
                                                                         MessageRef#message_ref{current_offset =
                                                                                                    MessageRef#message_ref.current_offset
                                                                                                    +
                                                                                                    5
                                                                                                    +
                                                                                                    4})}.

'internal_decode_schema.capnp:Node.struct'(All =
                                               <<_:112/integer,
                                                 VardataWordCount:16/little-unsigned-integer,
                                                 _:64/integer,
                                                 VarpointerCount:16/little-unsigned-integer,
                                                 VarpreferredListEncoding:16/little-unsigned-integer,
                                                 _:7/integer,
                                                 VarisGroup:1/integer,
                                                 _:8/integer,
                                                 VardiscriminantCount:16/little-unsigned-integer,
                                                 VardiscriminantOffset:32/little-unsigned-integer,
                                                 _:32/integer,
                                                 _:192/integer,
                                                 Varfields:64/little-unsigned-integer,
                                                 _:128/integer>>,
                                           MessageRef) ->
    #'schema.capnp:Node.struct'{dataWordCount = VardataWordCount,
                                pointerCount = VarpointerCount,
                                preferredListEncoding =
                                    element(VarpreferredListEncoding + 1,
                                            {empty,
                                             bit,
                                             byte,
                                             twoBytes,
                                             fourBytes,
                                             eightBytes,
                                             pointer,
                                             inlineComposite}),
                                isGroup =
                                    case VarisGroup of
                                        0 ->
                                            false;
                                        1 ->
                                            true
                                    end,
                                discriminantCount = VardiscriminantCount,
                                discriminantOffset =
                                    VardiscriminantOffset,
                                fields =
                                    follow_tagged_struct_list_pointer(fun 'internal_decode_schema.capnp:Field'/2,
                                                                      Varfields,
                                                                      MessageRef#message_ref{current_offset =
                                                                                                 MessageRef#message_ref.current_offset
                                                                                                 +
                                                                                                 5
                                                                                                 +
                                                                                                 3})}.

'internal_decode_schema.capnp:Superclass'(All =
                                              <<Varid:64/little-unsigned-integer,
                                                Varbrand:64/little-unsigned-integer>>,
                                          MessageRef) ->
    #'schema.capnp:Superclass'{id = Varid,
                               brand =
                                   follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                         Varbrand,
                                                         MessageRef#message_ref{current_offset =
                                                                                    MessageRef#message_ref.current_offset
                                                                                    +
                                                                                    1
                                                                                    +
                                                                                    0})}.

'internal_decode_schema.capnp:Type'(Body, MessageRef) ->
    <<_:0,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {void,undefined};
        1 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {bool,undefined};
        2 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {int8,undefined};
        3 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {int16,undefined};
        4 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {int32,undefined};
        5 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {int64,undefined};
        6 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {uint8,undefined};
        7 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {uint16,undefined};
        8 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {uint32,undefined};
        9 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {uint64,undefined};
        10 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {float32,undefined};
        11 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {float64,undefined};
        12 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {text,undefined};
        13 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {data,undefined};
        14 ->
            <<_:192,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {list,
             follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                                   Var,
                                   MessageRef#message_ref{current_offset =
                                                              MessageRef#message_ref.current_offset
                                                              +
                                                              3
                                                              +
                                                              0})};
        15 ->
            {enum,
             'internal_decode_schema.capnp:Type.enum'(Body, MessageRef)};
        16 ->
            {struct,
             'internal_decode_schema.capnp:Type.struct'(Body,
                                                        MessageRef)};
        17 ->
            {interface,
             'internal_decode_schema.capnp:Type.interface'(Body,
                                                           MessageRef)};
        18 ->
            {anyPointer,
             'internal_decode_schema.capnp:Type.anyPointer'(Body,
                                                            MessageRef)}
    end.

'internal_decode_schema.capnp:Type.anyPointer'(Body, MessageRef) ->
    <<_:64,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {unconstrained,undefined};
        1 ->
            {parameter,
             'internal_decode_schema.capnp:Type.anyPointer.parameter'(Body,
                                                                      MessageRef)};
        2 ->
            <<_:80,Var:16/little-unsigned-integer,_/bitstring>> = Body,
            {implicitMethodParameter,Var}
    end.

'internal_decode_schema.capnp:Type.anyPointer.implicitMethodParameter'(All =
                                                                           <<_:80/integer,
                                                                             VarparameterIndex:16/little-unsigned-integer,
                                                                             _:96/integer,
                                                                             _:64/integer>>,
                                                                       MessageRef) ->
    #'schema.capnp:Type.anyPointer.implicitMethodParameter'{parameterIndex =
                                                                VarparameterIndex}.

'internal_decode_schema.capnp:Type.anyPointer.parameter'(All =
                                                             <<_:80/integer,
                                                               VarparameterIndex:16/little-unsigned-integer,
                                                               _:32/integer,
                                                               VarscopeId:64/little-unsigned-integer,
                                                               _:64/integer>>,
                                                         MessageRef) ->
    #'schema.capnp:Type.anyPointer.parameter'{parameterIndex =
                                                  VarparameterIndex,
                                              scopeId = VarscopeId}.

'internal_decode_schema.capnp:Type.enum'(All =
                                             <<_:64/integer,
                                               VartypeId:64/little-unsigned-integer,
                                               _:64/integer,
                                               Varbrand:64/little-unsigned-integer>>,
                                         MessageRef) ->
    #'schema.capnp:Type.enum'{typeId = VartypeId,
                              brand =
                                  follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                        Varbrand,
                                                        MessageRef#message_ref{current_offset =
                                                                                   MessageRef#message_ref.current_offset
                                                                                   +
                                                                                   3
                                                                                   +
                                                                                   0})}.

'internal_decode_schema.capnp:Type.interface'(All =
                                                  <<_:64/integer,
                                                    VartypeId:64/little-unsigned-integer,
                                                    _:64/integer,
                                                    Varbrand:64/little-unsigned-integer>>,
                                              MessageRef) ->
    #'schema.capnp:Type.interface'{typeId = VartypeId,
                                   brand =
                                       follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                             Varbrand,
                                                             MessageRef#message_ref{current_offset =
                                                                                        MessageRef#message_ref.current_offset
                                                                                        +
                                                                                        3
                                                                                        +
                                                                                        0})}.

'internal_decode_schema.capnp:Type.list'(All =
                                             <<_:192/integer,
                                               VarelementType:64/little-unsigned-integer>>,
                                         MessageRef) ->
    #'schema.capnp:Type.list'{elementType =
                                  follow_struct_pointer(fun 'internal_decode_schema.capnp:Type'/2,
                                                        VarelementType,
                                                        MessageRef#message_ref{current_offset =
                                                                                   MessageRef#message_ref.current_offset
                                                                                   +
                                                                                   3
                                                                                   +
                                                                                   0})}.

'internal_decode_schema.capnp:Type.struct'(All =
                                               <<_:64/integer,
                                                 VartypeId:64/little-unsigned-integer,
                                                 _:64/integer,
                                                 Varbrand:64/little-unsigned-integer>>,
                                           MessageRef) ->
    #'schema.capnp:Type.struct'{typeId = VartypeId,
                                brand =
                                    follow_struct_pointer(fun 'internal_decode_schema.capnp:Brand'/2,
                                                          Varbrand,
                                                          MessageRef#message_ref{current_offset =
                                                                                     MessageRef#message_ref.current_offset
                                                                                     +
                                                                                     3
                                                                                     +
                                                                                     0})}.

'internal_decode_schema.capnp:Value'(Body, MessageRef) ->
    <<_:0,Discriminant:16/little-unsigned-integer,_/bitstring>> = Body,
    case Discriminant of
        0 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {void,undefined};
        1 ->
            <<_:23,Var:1/integer,_/bitstring>> = Body,
            {bool,
             case Var of
                 0 ->
                     false;
                 1 ->
                     true
             end};
        2 ->
            <<_:16,Var:8/little-signed-integer,_/bitstring>> = Body,
            {int8,Var};
        3 ->
            <<_:16,Var:16/little-signed-integer,_/bitstring>> = Body,
            {int16,Var};
        4 ->
            <<_:32,Var:32/little-signed-integer,_/bitstring>> = Body,
            {int32,Var};
        5 ->
            <<_:64,Var:64/little-signed-integer,_/bitstring>> = Body,
            {int64,Var};
        6 ->
            <<_:16,Var:8/little-unsigned-integer,_/bitstring>> = Body,
            {uint8,Var};
        7 ->
            <<_:16,Var:16/little-unsigned-integer,_/bitstring>> = Body,
            {uint16,Var};
        8 ->
            <<_:32,Var:32/little-unsigned-integer,_/bitstring>> = Body,
            {uint32,Var};
        9 ->
            <<_:64,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {uint64,Var};
        10 ->
            <<_:32,Var:32/little-float,_/bitstring>> = Body,
            {float32,Var};
        11 ->
            <<_:64,Var:64/little-float,_/bitstring>> = Body,
            {float64,Var};
        12 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {text,
             follow_text_pointer(Var,
                                 MessageRef#message_ref{current_offset =
                                                            MessageRef#message_ref.current_offset
                                                            +
                                                            2
                                                            +
                                                            0})};
        13 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {data,
             follow_data_pointer(Var,
                                 MessageRef#message_ref{current_offset =
                                                            MessageRef#message_ref.current_offset
                                                            +
                                                            2
                                                            +
                                                            0})};
        14 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {list,not_implemented};
        15 ->
            <<_:16,Var:16/little-unsigned-integer,_/bitstring>> = Body,
            {enum,Var};
        16 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {struct,not_implemented};
        17 ->
            <<_:0,Var:0/integer,_/bitstring>> = Body,
            {interface,undefined};
        18 ->
            <<_:128,Var:64/little-unsigned-integer,_/bitstring>> = Body,
            {anyPointer,not_implemented}
    end.



