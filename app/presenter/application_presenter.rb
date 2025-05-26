class ApplicationPresenter < SimpleDelegator
  def initialize(model)
    super(model)
  end
end
