# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-0.9.6-r1.ebuild,v 1.2 2003/09/11 01:21:31 msterret Exp $

IUSE=""

DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"
SRC_URI="mirror://alsaproject/tools/${P}.tar.bz2"

SLOT="0.9"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

DEPEND=">=media-libs/alsa-lib-0.9.6
	virtual/alsa
	=x11-libs/fltk-1.1*
	=x11-libs/gtk+-1.2*"

# This is a list of the tools in the package.
# Some of the tools don't make proper use of CFLAGS, even though
# all of them seem to use autoconf.  This needs to be fixed.
ALSA_TOOLS="ac3dec as10k1 envy24control hdsploader hdspmixer mixartloader rmedigicontrol sb16_csp seq/sbiload sscape_ctl vxloader"

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
		econf || die "configure failed"
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
