package promclient

import (
	"context"
	"time"

	v1 "github.com/prometheus/client_golang/api/prometheus/v1"
	"github.com/prometheus/common/model"
)

// API Subset of the interface defined in the prometheus client
type API interface {
	// LabelValues performs a query for the values of the given label.
	LabelValues(ctx context.Context, label string) (model.LabelValues, error)
	// Query performs a query for the given time.
	Query(ctx context.Context, query string, ts time.Time) (model.Value, error)
	// QueryRange performs a query for the given range.
	QueryRange(ctx context.Context, query string, r v1.Range) (model.Value, error)
	// Series finds series by label matchers.
	Series(ctx context.Context, matches []string, startTime time.Time, endTime time.Time) ([]model.LabelSet, error)
}
