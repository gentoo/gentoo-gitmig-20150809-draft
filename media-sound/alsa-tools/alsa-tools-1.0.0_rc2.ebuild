# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-1.0.0_rc2.ebuild,v 1.2 2003/12/17 04:36:57 brad_mssw Exp $

IUSE=""

DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"

MY_P=${P/_rc/rc}
SRC_URI="ftp://ftp.alsa-project.org/pub/tools/${MY_P}.tar.bz2"
#SRC_URI="mirror://alsaproject/tools/${P}.tar.bz2"
#RESTRICT="nomirror"

SLOT="0.9"
KEYWORDS="~x86 ~ppc ppc64"
LICENSE="GPL-2"
S=${WORKDIR}/${MY_P}

DEPEND=">=media-libs/alsa-lib-1.0.0_rc2
	virtual/alsa
	=x11-libs/fltk-1.1*
	=x11-libs/gtk+-1.2*"

# This is a list of the tools in the package.
# Some of the tools don't make proper use of CFLAGS, even though
# all of them seem to use autoconf.  This needs to be fixed.
ALSA_TOOLS="ac3dec as10k1 envy24control hdspmixer mixartloader rmedigicontrol \
	sb16_csp seq/sbiload vxloader"
# The below two tools do not compile with linux-headers from 2.4 kernels
# as of alsa-tools-0.9.7, so I removed them from the list for now.
# Bug reports have been sent to the alsa-devel mailing list.
#
# hdsploader
# sscape_ctl

src_compile() {
	# hdspmixer requires fltk
	export LDFLAGS="-L/usr/lib/fltk-1.1"
	export CPPFLAGS="-I/usr/include/fltk-1.1"

	# hdspmixer is missing depconf - copy from the hdsploader directory
	cp ${S}/hdsploader/depcomp ${S}/hdspmixer/

	local f
	for f in ${ALSA_TOOLS}
	do
		cd "${S}/${f}"
		econf --with-kernel="${KV}" || die "configure failed"
		make || die "make failed"
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
