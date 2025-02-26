all: test benchmark check

example: runners_example leader_directed_ring_example leader_undirected_ring_example leader_directed_clique_example leader_undirected_mesh_example leader_directed_hypercube_example leader_undirected_graph_example orientation_example size_estimation_example graphs_mst_example graphs_mis_example graphs_ds_example consensus_example

runners_example:
	go run example/synchronized.go 5

leader_directed_ring_example:
	go run example/leader_directed_ring_sync.go 10 chang_roberts
	go run example/leader_directed_ring_sync.go 10 dolev_klawe_rodeh_a
	go run example/leader_directed_ring_sync.go 10 dolev_klawe_rodeh_b
	go run example/leader_directed_ring_sync.go 10 itai_rodeh
	go run example/leader_directed_ring_sync.go 10 peterson
	go run example/leader_directed_ring_async.go 10 higham_przytycka
	go run example/leader_directed_ring_async.go 10 itai_rodeh

leader_undirected_ring_example:
	go run example/leader_undirected_ring_sync_hirschberg_sinclair.go 10
	go run example/leader_undirected_ring_sync_franklin.go 10
	go run example/leader_undirected_ring_sync_prob_as_far.go 10
	go run example/leader_undirected_ring_sync_higham_przytycka.go 10
	go run example/leader_undirected_ring_async_hirschberg_sinclair.go 10
	go run example/leader_undirected_ring_async_stages_with_feedback.go 10
	go run example/leader_undirected_ring_async_franklin.go 10
	go run example/leader_undirected_ring_async_probabilistic_franklin.go 10 3

leader_directed_clique_example:
	go run example/leader_clique_async_loui_matsushita_west.go 10
	go run example/leader_clique_async_loui_matsushita_west_2.go 10

leader_undirected_clique_example:
	go run example/leader_clique_async_korach_moran_zaks.go 10
	go run example/leader_clique_async_afek_gafni.go 10

leader_undirected_mesh_example:
	go run example/leader_undirected_mesh_sync_peterson.go 6 9

leader_directed_hypercube_example:
	go run example/leader_directed_hypercube_sync_hyperelect.go 6

leader_undirected_graph_example:
	go run example/leader_undirected_graph_sync_yoyo.go 20 0.25
	go run example/leader_undirected_graph_sync_casteigts_metivier_robson_zemmari.go 20 0.25

orientation_example:
	go run example/orientation_async_syrotiuk_pachl.go 10
	go run example/orientation_sync_torus_mans.go 25

size_estimation_example:
	go run example/size_estimation_directed_ring_async_itai_rodeh.go 10
	go run example/size_estimation_directed_ring_async_itai_rodeh_2.go 10

consensus_example:
	go run example/consensus_sync_ben_or.go 11 2  0 1 0 1 0 1 1 0 0 0 1  1 2  Random
	go run example/consensus_sync_ben_or.go 11 2  0 1 0 1 0 1 1 0 0 0 1  1 2  Optimal
	go run example/consensus_sync_phase_king.go 10 3  0 1 0 1 0 1 1 0 0 0  1 2 3  Random
	go run example/consensus_sync_phase_king.go 10 3  0 1 0 1 0 1 1 0 0 0  1 2 3  Optimal
	go run example/consensus_sync_single_bit.go 9 2  0 1 0 1 0 1 1 0 0  1 2  Random
	go run example/consensus_sync_single_bit.go 9 2  0 1 0 1 0 1 1 0 0  1 2  Optimal

byzantine_example:
	go run example/byzantine_sync_chor_coan.go 7 2  0 0 -1 1 0 -1 0

graphs_mst_example:
	go run example/graphs_mst_sync_ghs.go 10 30 100

graphs_mis_example:
	go run example/graphs_mis_sync_luby.go 20 0.25
	go run example/graphs_mis_sync_metivier_c.go 20 0.25
	go run example/graphs_mis_sync_metivier_a.go 20 0.25

graphs_ds_example:
	go run example/graphs_ds_sync_lrg.go 10 0.70
	go run example/graphs_ds_sync_kuhn_wattenhofer.go 101 0.05 4

unit_test:
	go test ./leader/undirected_graph/sync_yoyo -v
	go test ./graphs/mst/sync_ghs -v

test:
	go test ./test -run . -v

benchmark:
	go test ./test -bench . -benchtime 10x -run Benchmark -v -timeout 30m

check:
	@go vet `go list ./... | grep -v example`

format:
	gofmt -l -s -w .

.PHONY: all unit_test test benchmark
