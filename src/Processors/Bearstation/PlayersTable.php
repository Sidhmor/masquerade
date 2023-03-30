<?php
declare(strict_types=1);

namespace Processors\Bearstation;

use Elgentos\Masquerade\DataProcessor;
use Elgentos\Masquerade\DataProcessor\TableService;
use Elgentos\Masquerade\Output;

class PlayersTable implements DataProcessor
{
    /** @var Output */
    private $output;

    /** @var array */
    private $configuration;

    /** @var TableService */
    private $tableService;

    public function __construct(Output $output, TableService $tableService, array $configuration)
    {
        $this->output = $output;
        $this->tableService = $tableService;
        $this->configuration = $configuration;
    }

    public function truncate(): void
    {
        $this->tableService->truncate();
    }

    public function delete(): void
    {
        $this->tableService->delete($this->configuration['provider']['where'] ?? '');
    }

    public function updateTable(int $batchSize, callable $generator): void
    {
        $columns = $this->tableService->filterColumns($this->configuration['columns'] ?? []);
        $primaryKey = $this->configuration['pk'] ?? $this->tableService->getPrimaryKey();
        var_dump($batchSize);

        $this->tableService->updateTable(
            $columns,
            $this->configuration['provider']['where'] ?? '',
            $primaryKey,
            $this->output,
            $generator,
            $batchSize
        );
    }
}