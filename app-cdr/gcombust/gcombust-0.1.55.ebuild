# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcombust/gcombust-0.1.55.ebuild,v 1.8 2004/11/21 09:53:51 sekretarz Exp $

inherit gnuconfig

DESCRIPTION="A GUI for mkisofs/mkhybrid/cdda2wav/cdrecord/cdlabelgen."
HOMEPAGE="http://www.abo.fi/~jmunsin/gcombust/"
SRC_URI="http://www.abo.fi/~jmunsin/gcombust/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
	app-cdr/cdrtools"

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	fi
	gnuconfig_update
}

src_compile() {
	local myconf

	if ! use nls
	then
		myconf="${myconf} --disable-nls"
		touch intl/libintl.h
	else
		myconf="${myconf} --enable-nls"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO
	dohtml -a shtml FAQ.shtml
}
