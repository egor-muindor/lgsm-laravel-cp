<?php

declare(strict_types=1);

namespace App\Console\Commands;

use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;

class DeleteTmpFiles extends Command
{
    /**
     * @var string
     */
    protected $signature = 'tmp:clean';

    /**
     * @var string
     */
    protected $description = 'Clear temporary storage';

    protected int $lifeTime;

    /**
     * @return void
     */
    public function __construct()
    {
        parent::__construct();

        $this->lifeTime = (int) config('filesystem.disks.temp.lifetime', 5 * 60);
    }

    public function handle(): void
    {
        $files = Storage::disk('temp')->allFiles();
        $now = Carbon::now();

        foreach ($files as $file) {
            $modTimestamp = Storage::disk('temp')->lastModified($file);
            $modeDate = Carbon::createFromTimestamp($modTimestamp);

            $length = $modeDate->diffInSeconds($now);

            if ($length > $this->lifeTime) {
                Storage::disk('temp')->delete($file);
            }
        }
    }
}
