# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/namazu/namazu-2.0.12.ebuild,v 1.1 2003/06/20 16:46:41 yakina Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Namazu is a full-text search engine"
SRC_URI="http://www.namazu.org/stable/${P}.tar.gz"
HOMEPAGE="http://www.namazu.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls cjk kakasi chasen tcltk"

DEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/File-MMagic-1.12
	nls? ( >=sys-devel/gettext-0.10.35 )
	cjk? ( >=app-i18n/nkf-1.71 )
	kakasi? ( >=dev-perl/Text-Kakasi-1.05 )
	chasen? ( >=dev-perl/Text-ChaSen-1.03 )
	tcltk? ( >=dev-lang/tk-8.3.3 
		>=net-www/lynx-2.8.4 )"

#RDEPEND=$DEPEND

src_compile() {
	local myconf="";

	use nls || myconf="${myconf} --disable-nls"
	use tcltk && myconf="${myconf} --enable-tknamazu"

	econf ${myconf} || die "./configure failed"

	mv filter/Makefile filter/Makefile.orig
	sed -e 's|\(rm -f \$(filterdir).*$\)|# \1|' filter/Makefile.orig > filter/Makefile
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm ${D}/usr/share/namazu/etc/*

	insinto /usr/share/namazu/etc
	doins etc/namazu.png
	doins lisp/*.el

	dodoc AUTHORS COPYING CREDITS NEWS TODO THANKS
	dodoc ChangeLog* README* HACKING* INSTALL*
}
