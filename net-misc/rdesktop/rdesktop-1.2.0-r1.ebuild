# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.2.0-r1.ebuild,v 1.5 2003/09/05 22:01:49 msterret Exp $

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~sparc"
IUSE="ssl debug"

DEPEND="x11-base/xfree
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Apply patch from Steve Fosdick to do rudimentary X->TS
	# cut'n'paste.  This isn't really supported by the RDP4 protocol,
	# but official support for clipboard interaction will be in RDP5.
	# http://sf.net/mailarchive/forum.php?thread_id=1920955&forum_id=8865
	epatch ${FILESDIR}/rdesktop-paste.patch

	# Note there is an additional patch further down that conversation
	# to send a middle click to TS if the clipboard is empty.  I
	# don't think I'll need that.  If somebody wants to add it here,
	# that's fine for a later rev...
}

src_compile() {
	local myconf
	use ssl \
		&& myconf="--with-openssl=/usr/include/openssl" \
		|| myconf="--without-openssl"

	sed -e "s:-O2:${CFLAGS}:g" Makefile > Makefile.tmp
	mv Makefile.tmp Makefile
	echo "CFLAGS += ${CXXFLAGS}" >> Makeconf

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--sharedir=/usr/share/${PN} \
		`use_with debug` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING doc/HACKING doc/TODO doc/keymapping.txt
}
