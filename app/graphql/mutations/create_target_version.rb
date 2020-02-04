module Mutations
  class CreateTargetVersion < GraphQL::Schema::Mutation
    argument :target_id, ID, required: true
    argument :version_at, GraphQL::Types::ISO8601DateTime, required: false

    description "Update a target"

    field :success, Boolean, null: false

    def resolve(params)
      mutator = CreateTargetVersionMutator.new(context, params)

      if mutator.valid?
        mutator.notify(:success, 'Done!', 'Target version created successfully!')
        mutator.create_target_version
        { success: true }
      else
        mutator.notify_errors
        { success: false }
      end
    end
  end
end