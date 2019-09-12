rec {
  admins =
    aither.all
    ++
    [ snajpa ];

  builders = [
    build-vpsfree-cz
  ];

  aither = rec {
    ws = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJL5CEMBEQA704OIgyg8/1WX4Z63gVXvvaIrz1jLSMlBdnE0daUdeD7NLCsV+RIZGywQj44im6lW8ahGdj4ivXHeLxaCCaWfzYMa2Q9AmQwJFQIrA8l+9c5bFaesMugaHJcEbS/hykuuaCyq8G77WSZVvoYVsM8Hte0hasEi5c6BrDY+54N01gnRdlkZ6Kw2HhGsh8jddAppapR69kA16Qn0FK9JMMY4WhoV7vOawn+RbpmryUP8B7rKcUFMXo1Q9ULF7igRLMpFDdG0OD9dIDv/WaRh8NKMFMUKsot9zONKf2krsjRNVjwBtY2RId1zkTseNrvjXcOjrp0VudG1t97VBqwIUm0ISnysfUz73hmVBvNPhE8yQ8Qy0Z3LVHxDWxH2mN8uwVXG8F16Z7n+Lgu8m8C8P+1wTGTbZtrtVYNwF+SpRNGrfVxI+RKFAIa9K+rZDR8THhO4MRhJuQlIEwhIBw3vSPxGrYODZv6vaEse/3wdi4Sztcv+n5MxrAn9mqfycE3LNXE2ZBQtXyxnKEq/XnPAcWJeLoLqKe4zehXoKKPXl5TcaTuv2UWpVDywGGwGoNucVLulMiUVE0F7At1G5h83lq78uVz2cJyNEwi2VkW72sgSlSKZgGtFwmGHKX1MlEZl5W/A9Tz0InnqRQUsSHg5gwOIjV9d+0IGvnyw== aither@orion";

    ipad = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDgH5J3Wu48WaFzqnSzNpgoSa6RluosBC3CCpRNZDwb0/5nzs/YyES463vPbMqJEzcFt8KxeOFoWSZUruzgTTtTr4jRNqVG77XA7TN9mU8qullXiP91OPk9FYxLYh57Bi+FvIKmR8WAS5t0YMFecch9NVBY5WB8QxT8P2n1hA4jxjbVB42lgeAAsSmHshH3DUHGWnQw268FspS1fXbV8x8dOLlUoqCGtxUULGD6uXew4X4QN26PDe3+4ELY2ev+UK/BL0r8P/nNykm+QyqiSrpuZe+dG7x7ebqkrf1HpFvwioM5RUfnCzDkK2A+IfKlM3iopksdmc/6cRxXx7MquVo3hL1hYwPaJOwPlrBsPrJwVQ5NFPfXv2OjUYIDXPDadNFrGbC008I0g+1NUtrKwMwqeME6QMJfzwwcnQuig83xdSx6nekNp16nz6X/7ttT2X+HJFURlhdfNFpaxdRQaX0qlAeHV552qJNMcFpHwhsQRFePLcKob9HZH3W7jCueTD0TagbdOrvMFhYsVhkAjKFL07OKRAwc1O07uFxS8L5EmLJCqqEq5Di17k7XT8EKrzcBcF3SidrpJU+QJ/xMgVyHQXSxTgwQva2N4Bmi8jtKipoqQRWkAtiRvQqFargTpSnq+wxZL7i2EfyMMUPk55+2iork2my01M+L/7ct9ASOTw== mobile@ipad";

    all = [ ws ipad ];
  };

  snajpa = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBK29/yHdxakVaJMYiIMBKb8nYGaj/gSQI4zErNVcbvsUpSiQuD+TLhIWYxR79D9rHFypMRm6aaEbeMHtw+TRjoI= snajpa@snajpaStation";
  srk = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDUus8o86CftVSj2yJU0P0cCbeWIPt7x0SenQLS7cjnWoXOGWvUr1AVdPl3dAVeoE1pnDNLYxLblQ18lsmnIxfo= rmarko@grampi";
  srk_devel = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPwzvONGTj+vxMdDrZXIebGmXBD1z34AiOTrS/pg+UJlYoIhEvmmITlPEwnl4+34WaxBSXmorvyn2PCETg8xq8jt+RKJHGe1/GKb91yvu3wMpbMCholm4zNF5rzF9irhAa7qsvfLmd55IRNEqxPUYmiXI+QREasD55CHPuw85AnUbrnYKJtEKL7ckTjy/FOJYfZoynjsbIyeMz65yYGF+T5aNDGyA8kkMUieAlkWO0pZKhKhBnLJydPqgy8zWqiiQW31g/q59Q+WT1U7kIBeyPzW8F1cw/CPLNmRhDuwBfxHKWVqSSvtcjuiw62VZxSKBaNc28dU78D4UgDnCGWDel root@nixos1337";
  srk_new = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZYnC8Q/QY+owUdCguigQZpsYKa/92lIo0Gu/w2g/+P srk@48.io";

  build-vpsfree-cz = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1qn/zZ6OUdlU23/yMG10c+BkqMKTNW1TUMwj8RqwfBaE4bAVeNfRGZdx/8VA0Wq50L09oPd+iVFI9BWXvpRwK31ZnaiIeoJUtBzqiBM1RXc+7Xj2L2NJlX1MHjcprxX6T5MBPRbimAT2/pcGPDwgedCmT3C9gPm6xo+bHZReD7fs8TWodU81lM4U3mOwprF50lhH3SFu6SDUuiksjS0IciL54fPQJm3FU0SaM8OinUBCpG327pMAiA87CneKM7PWI01k/q/2YDByQgwGA6CnLGYv6BRUpCxGXjm2FWQ2kgD6H8/g9Rlt2st2mtoBbMqBQHwCCdJklUra5zzn+ieItCHZpfQfxe/Gwn9+Eb21Joasn/K1N7Y+r+rQb/tZe7BnOoyV/f1kZBx5gSCQlv3tyqtpArurLlCZwJvG83IA56DH//ymJvlrckF/tQXdfOfk86Z5h/7uxMNvlhFeZXp0DjdTu9lh96ThXtiPt7mnDJFHjcsLiws/Szbs7IhdF+nh6Ai8PfYozZAIdRnxqa6kfL05NAsxiXcaY2SsBDok4KGfcZhJKMUanfO6i2tJ4Amy37Bz6wHU98dhoAE0o0Embogh+xuW0D8lPxeKYjpbF6m/pCDXDg1KX6SPd43NnLBC7WclBy4dLguviIPidZN0ejCGN3bxGg6y+/ZUa3+/ANQ== root@build";
}
