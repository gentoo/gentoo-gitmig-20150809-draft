# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>
# Maintainer: Jerry A! <jerry@thehutt.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gkrellm-seti/gkrellm-seti-0.7.0.ebuild,v 1.1 2001/12/12 06:26:53 jerrya Exp $

S=${WORKDIR}/${P//gkrellm-}
DESCRIPTION="a Seti@Home Monitor Plugin for Gkrellm"
SRC_URI="http://xavier.serpaggi.free.fr/seti/${P//gkrellm-}.tar.bz2"

HOMEPAGE="http://xavier.serpaggi.free.fr/seti"

DEPEND=">=app-admin/gkrellm-0.10.3"


src_compile() {
	make || die
}

src_install () {
	exeinto /usr/lib/gkrellm/plugins
	doexe seti.so
	dodoc README ChangeLog COPYING NEWS
}
