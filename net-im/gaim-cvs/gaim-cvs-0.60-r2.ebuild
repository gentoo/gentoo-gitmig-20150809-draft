# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-cvs/gaim-cvs-0.60-r2.ebuild,v 1.7 2003/03/11 21:11:46 seemant Exp $

IUSE="nas nls esd arts perl spell"

DESCRIPTION="GTK Instant Messenger client - CVS ebuild."
HOMEPAGE="http://gaim.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="=sys-libs/db-1*
	!net-im/gaim
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	esd? ( >=media-sound/esound-0.2.22-r2 )
	nls? ( sys-devel/gettext )
	nas? ( >=media-libs/nas-1.4.1-r1 )
	arts? ( >=kde-base/arts-0.9.5 )
	perl? ( >=dev-lang/perl-5.6.1 )
	spell? ( >=app-text/gtkspell-2.0.2 )"

inherit cvs

ECVS_SERVER="cvs.gaim.sourceforge.net:/cvsroot/gaim"
ECVS_MODULE="gaim"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	local myconf="--prefix=/usr"

	use esd  || myconf="${myconf} --disable-esd"
	use perl || myconf="${myconf} --disable-perl"
	use nas  && myconf="${myconf} --enable-nas" \
		 || myconf="${myconf} --disable-nas"
	use spell || myconf="${myconf} --disable-gtkspell"

	if [ "` use arts`" ]; then
	    inherit kde-functions
	    set-kdedir 3
	    # $KDEDIR now points to arts location
	else
	    myconf="${myconf} --disable-artsc"
	fi

	use nls  || myconf="${myconf} --disable-nls"

	./autogen.sh ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO ChangeLog
}
