
@resultBuilder
struct ItsukiViewBuilder {
    
    static func buildBlock<Content>(_ content: Content) -> Content
    where Content: View {
        content
    }

    static func buildBlock<each Content>(_ content: repeat each Content)
        -> TupleView<(repeat each Content)> where repeat each Content: View
    {
        TupleView((repeat each content))
    }

    static func buildArray(
        _ components: [some View]
    ) -> some View {
        VStack {
            ForEach(Array(components.enumerated()), id: \.offset) { _, view in
                view
            }
        }
    }

    static func buildExpression<Content>(_ content: Content) -> Content
    where Content: View {
        content
    }

    // with Swift Secret API. Will get `a 'init(_storage:)' is deprecated warning`.
    //static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> _ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
    //    _ConditionalContent(_storage: .trueContent(first))
    //}
    //
    //static func buildEither<TrueContent, FalseContent>(second: FalseContent) -> _ConditionalContent<TrueContent, FalseContent> where TrueContent : View, FalseContent : View {
    //    _ConditionalContent(_storage: .falseContent(second))
    //}

    // build either with erased type if we don't want to use non-public API
    static func buildEither<TrueContent>(first: TrueContent) -> AnyView
    where TrueContent: View {
        AnyView(first)
    }

    static func buildEither<FalseContent>(second: FalseContent) -> AnyView
    where FalseContent: View {
        AnyView(second)
    }

    static func buildIf<Content>(_ content: Content?) -> Content?
    where Content: View {
        content
    }

    // If declared, this will be called on the partial result of an 'if
    // #available' block to allow the result builder to erase type
    // information.
    static func buildLimitedAvailability<Content>(_ content: Content) -> AnyView
    where Content: View {
        AnyView(content)
    }
}
