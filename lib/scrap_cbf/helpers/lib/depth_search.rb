# frozen_string_literal: true

class ScrapCbf
  # This module use recursion and regex to find specifics methods on the dom.
  # A better use case for this method is searching on a component view
  # that has small text wrapped only on a html tag without a specific class
  module DepthSearch
    # Search element's children recursively and returns first assertion matched.
    #
    # The assertion must be passed through a proc, and must return nil for
    # false assertions and the element searched for true assetions.
    #
    # @param element [Nokogiri::XML::Element] to be searched.
    # @param proc [Proc] with logic to test assertion.
    # @return [Object, nil] object may be text element or a dom element.
    def depth_search(element, proc)
      res = nil
      counter = 0
      number_of_children = element.children.length

      while counter < number_of_children

        child = element.children[counter]
        res = proc.call(child)

        return res if res # recursion base case #1 - return when found

        res = depth_search(child, proc)

        return res if res # recursion base case #2 - return from recursion

        counter += 1
      end
      res
    end
  end
end
