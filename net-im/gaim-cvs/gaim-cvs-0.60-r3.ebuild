# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-cvs/gaim-cvs-0.60-r3.ebuild,v 1.4 2003/03/03 18:37:26 mholzer Exp $

IUSE="nls perl spell"

DESCRIPTION="GTK Instant Messenger client - CVS ebuild."
HOMEPAGE="http://gaim.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="=sys-libs/db-1*
	!net-im/gaim
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=media-libs/audiofile-0.2.0
	media-libs/libao
	nls? ( sys-devel/gettext )
	perl? ( >=sys-devel/perl-5.6.1 )
	spell? ( >=app-text/gtkspell-2.0.2 )"

inherit cvs

ECVS_SERVER="cvs.gaim.sourceforge.net:/cvsroot/gaim"
ECVS_MODULE="gaim"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	local myconf="--prefix=/usr"

	use perl || myconf="${myconf} --disable-perl"
	use spell || myconf="${myconf} --disable-gtkspell"

	use nls  || myconf="${myconf} --disable-nls"

	./autogen.sh ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO ChangeLog
}
