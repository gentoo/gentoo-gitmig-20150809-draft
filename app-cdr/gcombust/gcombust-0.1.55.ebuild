# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcombust/gcombust-0.1.55.ebuild,v 1.3 2004/01/27 14:19:20 gustavoz Exp $

DESCRIPTION="A GUI for mkisofs/mkhybrid/cdda2wav/cdrecord/cdlabelgen."
HOMEPAGE="http://www.abo.fi/~jmunsin/gcombust/"
LICENSE="GPL-2"

IUSE="nls"
KEYWORDS="x86 ~ppc sparc"

DEPEND="=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}
	app-cdr/cdrtools"

SRC_URI="http://www.abo.fi/~jmunsin/gcombust/${P}.tar.gz"
S=${WORKDIR}/${P}

SLOT="0"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
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
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	dohtml -a shtml FAQ.shtml
}
