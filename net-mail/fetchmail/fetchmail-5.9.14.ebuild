# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-5.9.14.ebuild,v 1.15 2004/07/15 01:47:27 agriffis Exp $

IUSE="ssl nls"

DESCRIPTION="Fetchmail is a full-featured remote-mail retrieval and forwarding utility"
HOMEPAGE="http://catb.org/~esr/fetchmail/"
SRC_URI="http://www.catb.org/~esr/fetchmail/${P}.tar.gz"

DEPEND="virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6 )"
RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="x86 ppc sparc"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/configure-5.9.14.diff || die "patch failed"

}

src_compile() {

	local myconf

	use ssl && myconf="${myconf} --with-ssl=/usr"

	use nls || myconf="${myconf} --disable-nls"

	# This needs inet6-apps, which we don't have
	#use ipv6 && myconf="{myconf} --enable-inet6"

	econf \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		${myconf} || die "Configuration failed."

	emake || die "Compilation failed."

}

src_install() {

	make DESTDIR="${D}" install || die

	dohtml *.html

	dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README \
		README.NTLM README.SSL TODO COPYING MANIFEST

	doman /usr/share/man/*.1
	dosym /usr/share/man/man1/fetchmailconf* /usr/share/man/man1/fetchmail.1.gz

	exeinto /etc/init.d
	doexe ${FILESDIR}/fetchmail

	docinto contrib
	local f
	for f in contrib/*
	do
		[ -f "${f}" ] && dodoc "${f}"
	done
}

pkg_postinst() {

	if ! python -c "import Tkinter" >/dev/null 2>&1
	then
		einfo
		einfo "You will not be able to use fetchmailconf(1), because you"
		einfo "don't seem to have Python with tkinter support."
		einfo
		einfo "If you want to be able to use fetchmailconf(1), do the following:"
		einfo "  1.  Include 'tcltk' in USE variable in your /etc/make.conf."
		einfo "  2.  (Re-)merge Python."
		einfo
	fi

}
