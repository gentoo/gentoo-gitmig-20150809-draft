# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtoaster/gtoaster-1.0_beta6.ebuild,v 1.10 2003/09/05 22:57:44 msterret Exp $

# Fix so that updating can only be done by 'cp old.ebuild new.ebuild'
MY_P="`echo ${P} |sed -e 's:-::' -e 's:_b:B:'`"
S=${WORKDIR}/${PN}

DESCRIPTION="GTK+ Frontend for cdrecord"
SRC_URI="http://gnometoaster.rulez.org/archive/${MY_P}.tgz"
HOMEPAGE="http://gnometoaster.rulez.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "
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

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/scdtosr.diff || die "patch failed"
}

src_compile() {
	local myconf=""
	use nls	|| myconf="$myconf --disable-nls"

	use gnome \
		&& myconf="$myconf --with-gnome --with-orbit" \
		|| myconf="$myconf --without-gnome --without-orbit"

	use esd \
		&& myconf="$myconf --with-esd" \
		|| myconf="$myconf --without-esd"

	use oss \
		&& myconf="$myconf --with-oss" \
		|| myconf="$myconf --without-oss"

	econf ${myconf}
	emake || die "parallel make failed"
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS ChangeLog* COPYING INSTALL NEWS README TODO

	# Install icon and .desktop for menu entry
	if [ `use gnome` ] ; then
		insinto /usr/share/pixmaps
		doins ${S}/icons/gtoaster.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/gtoaster.desktop
	fi
}
