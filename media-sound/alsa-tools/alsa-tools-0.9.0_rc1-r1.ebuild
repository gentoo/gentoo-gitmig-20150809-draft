# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-0.9.0_rc1-r1.ebuild,v 1.7 2003/06/16 22:28:48 spider Exp $

S="${WORKDIR}/${P/_rc/rc}"
DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"
SRC_URI="ftp://ftp.alsa-project.org/pub/tools/${P/_rc/rc}.tar.bz2"

SLOT="0.9"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/alsa-lib-0.9.0_rc1
	=x11-libs/gtk+-1.2*"

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
