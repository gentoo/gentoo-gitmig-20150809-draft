# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-0.9.1.ebuild,v 1.2 2003/04/15 20:11:24 agenkin Exp $

DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"
LICENSE="GPL-2"

DEPEND=">=media-libs/alsa-lib-0.9.1
	>=x11-libs/gtk+-1.0.1"

SLOT="0.9"
KEYWORDS="x86 ~ppc"

SRC_URI="ftp://ftp.alsa-project.org/pub/tools/${P}.tar.bz2"
S="${WORKDIR}/${P}"

# This is a list of the tools in the package.
ALSA_TOOLS="ac3dec as10k1 envy24control sb16_csp seq/sbiload"

src_compile() {
    # Some of the tools don't make proper use of CFLAGS, even though
    # all of them seem to use autoconf.  This needs to be fixed.
    local f
    for f in ${ALSA_TOOLS}
    do
	cd "${S}/${f}"

	econf || die "./configure failed"
	emake || die "Parallel Make Failed"
    done
}

src_install() {
    local f
    for f in ${ALSA_TOOLS}
    do
	# Install the main stuff
	cd "${S}/${f}"
	make DESTDIR="${D}" install || die

	# Install the text documentation
	local doc
	for doc in README TODO ChangeLog COPYING AUTHORS
	do
	    if [ -f "${doc}" ]
	    then
		mv "${doc}" "${doc}.`basename ${f}`"
		dodoc "${doc}.`basename ${f}`"
	    fi
	done
    done
}
