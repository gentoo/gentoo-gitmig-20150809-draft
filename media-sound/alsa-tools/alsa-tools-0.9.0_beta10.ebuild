# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Arcady Genkin <agenkin@thpoon.com>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-0.9.0_beta10.ebuild,v 1.1 2002/02/17 08:04:30 agenkin Exp $

DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"
DEPEND="virtual/glibc 
        ~media-lib/alsa-lib-0.9.0.1_beta10
        >=x11-libs/gtk+-1.0.1"

#transform P to match tarball versioning
MYPV="${PV/_beta/beta}"
MYP="${PN}-${MYPV}"
S="${WORKDIR}/${MYP}"

SRC_URI="ftp://ftp.alsa-project.org/pub/tools/${MYP}.tar.bz2"


ALSA_TOOLS="ac3dec as10k1 envy24control sb16_csp seq/sbiload"

src_compile() {
        # Some of the tools don't make proper use of CFLAGS, even though
        # all of them seem to use autoconf.  This needs to be fixed.
        local f
        for f in ${ALSA_TOOLS}
        do
            cd "${S}/${f}"
            ./configure --host="${CHOST}" \
                        --prefix=/usr \
                        || die "./configure failed"
            emake || die "Parallel Make Failed"
        done
}

src_install() {
        local f
        for f in ${ALSA_TOOLS}
        do
            cd "${S}/${f}"
            make DESTDIR="${D}" install || die
        done
}
