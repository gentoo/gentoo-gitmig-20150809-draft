# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-tools/alsa-tools-1.0.8-r1.ebuild,v 1.3 2005/03/29 18:52:06 corsair Exp $

IUSE="X"

inherit gnuconfig eutils

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture tools"
HOMEPAGE="http://www.alsa-project.org"
SRC_URI="mirror://alsaproject/tools/${P}.tar.bz2"

SLOT="0.9"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
LICENSE="GPL-2"

DEPEND=">=media-libs/alsa-lib-1.0.0
	virtual/alsa
	X? ( =x11-libs/fltk-1.1*
	     =x11-libs/gtk+-1.2* )"

# This is a list of the tools in the package.
# Some of the tools don't make proper use of CFLAGS, even though
# all of them seem to use autoconf.  This needs to be fixed.
#
# By default, all the supported tools will be compiled.
# If you want to only compile for specific tool(s), set ALSA_TOOLS
# environment to a space-separated list of tools that you want to build.
# For example:
#
#   env ALSA_TOOLS='as10k1 ac3dec' emerge alsa-tools
#
if [ -z "${ALSA_TOOLS}" ]; then
	if use X; then
		ALSA_TOOLS="ac3dec as10k1 envy24control hdspconf hdsploader hdspmixer \
		            mixartloader rmedigicontrol seq/sbiload sscape_ctl \
		            us428control usx2yloader vxloader"
	else
		ALSA_TOOLS="ac3dec as10k1 hdsploader mixartloader seq/sbiload \
					sscape_ctl us428control usx2yloader vxloader"
	fi

	# sb16_csp won't build on ppc64 _AND_ ppc (and is not needed)
	if  use !ppc64 && use !ppc; then
		ALSA_TOOLS="${ALSA_TOOLS} sb16_csp"
	fi

fi

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.0.6-gcc34.patch
	gnuconfig_update
}

src_compile() {
	# hdspmixer requires fltk
	export LDFLAGS="-L/usr/$(get_libdir)/fltk-1.1"
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
		for doc in README TODO ChangeLog AUTHORS
		do
			if [ -f "${doc}" ]
			then
			mv "${doc}" "${doc}.`basename ${f}`"
			dodoc "${doc}.`basename ${f}`"
			fi
		done
	done
}
