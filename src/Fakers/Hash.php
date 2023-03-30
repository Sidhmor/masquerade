<?php
declare(strict_types=1);

namespace Fakers;

use Faker\Provider\Base;

class Hash extends Base
{
    public function hashMD5(): string
    {
        return hash('md5', $this->generator->text);
    }
}