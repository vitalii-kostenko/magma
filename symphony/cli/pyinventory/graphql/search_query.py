#!/usr/bin/env python3
# @generated AUTOGENERATED file. Do not Change!

from dataclasses import dataclass
from datetime import datetime
from gql.gql.datetime_utils import DATETIME_FIELD
from gql.gql.graphql_client import GraphqlClient
from functools import partial
from numbers import Number
from typing import Any, Callable, List, Mapping, Optional

from dataclasses_json import DataClassJsonMixin


@dataclass
class SearchQuery(DataClassJsonMixin):
    @dataclass
    class SearchQueryData(DataClassJsonMixin):
        @dataclass
        class SearchNodesConnection(DataClassJsonMixin):
            @dataclass
            class SearchNodeEdge(DataClassJsonMixin):
                @dataclass
                class Node(DataClassJsonMixin):
                    @dataclass
                    class LocationType(DataClassJsonMixin):
                        name: str

                    typename: str
                    id: str
                    name: str
                    locationType: LocationType
                    externalId: Optional[str] = None

                node: Optional[Node] = None

            edges: List[SearchNodeEdge]

        searchForNode: SearchNodesConnection

    data: SearchQueryData

    __QUERY__: str = """
    query SearchQuery(
  $name: String!
  $after: Cursor
  $first: Int = 10
  $before: Cursor
  $last: Int
) {
  searchForNode(
    name: $name
    after: $after
    first: $first
    before: $before
    last: $last
  ) {
    edges {
      node {
        typename: __typename
        ... on Location {
          id
          externalId
          name
          locationType {
            name
          }
        }
      }
    }
  }
}

    """

    @classmethod
    # fmt: off
    def execute(cls, client: GraphqlClient, name: str, after: Optional[str] = None, first: Optional[int] = 10, before: Optional[str] = None, last: Optional[int] = None) -> SearchQueryData:
        # fmt: off
        variables = {"name": name, "after": after, "first": first, "before": before, "last": last}
        response_text = client.call(cls.__QUERY__, variables=variables)
        return cls.from_json(response_text).data
