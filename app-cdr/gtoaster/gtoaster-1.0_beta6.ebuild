# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtoaster/gtoaster-1.0_beta6.ebuild,v 1.17 2004/01/29 18:12:53 brad_mssw Exp $

# Fix so that updating can only be done by 'cp old.ebuild new.ebuild'
MY_P="${P/-}"
MY_P="${MY_P/_b/B}"

DESCRIPTION="GTK+ Frontend for cdrecord"
HOMEPAGE="http://gnometoaster.rulez.org/"
SRC_URI="http://gnometoaster.rulez.org/archive/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="nls esd gnome oss oggvorbis"

DEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2 )
	esd? ( >=media-sound/esound-0.2.22 )"
RDEPEND="=x11-libs/gtk+-1.2*
	>=app-cdr/cdrtools-1.11
	app-cdr/cdrdao
	>=media-sound/sox-12
	>=media-sound/mpg123-0.59
	>=media-sound/mp3info-0.8.4
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2 )
	esd? ( >=media-sound/esound-0.2.22 )
	oggvorbis? ( >=media-sound/vorbis-tools-1.0_rc2
		>=media-sound/oggtst-0.0 )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/scdtosr.diff
	epatch ${FILESDIR}/configure.in.diff
}

src_compile() {
	touch configure
	touch `find . -name \*.m4`
	touch `find . -name \*.in`

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6

	# Uhh, it loops indefinately otherwise
		cd ${S}
		libtoolize -c -f
		aclocal
		autoheader
		automake -a -c
		autoconf
	#end fix for indefinate loop

	econf \
		--disable-nls \
		`use_with gnome` \
		`use_with gnome orbit` \
		`use_with esd` \
		`use_with oss` \
		|| die
	emake || die "parallel make failed"
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS AUTHORS ChangeLog* COPYING INSTALL NEWS README TODO

	# Install icon and .desktop for menu entry
	if [ `use gnome` ] ; then
		insinto /usr/share/pixmaps
		doins ${S}/icons/gtoaster.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/gtoaster.desktop
	fi
}
