# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-6.1.0.ebuild,v 1.4 2002/10/08 15:44:57 raker Exp $

IUSE="ssl nls"

S="${WORKDIR}/${P}"

DESCRIPTION="Fetchmail is a full-featured remote-mail retrieval and forwarding utility"
HOMEPAGE="http://www.tuxedo.org/~esr/fetchmail/"
SRC_URI="http://www.tuxedo.org/~esr/fetchmail/${P}.tar.gz"
        
DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6 )
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="x86"

src_compile() {

	local myconf

	use ssl && myconf="${myconf} --with-ssl=/usr" \
		|| myconf="${myconf} --without-ssl"

	use nls && myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	# This needs inet6-apps, which we don't have
	#use ipv6 && myconf="${myconf} --enable-inet6 --enable-netsec"
	#	|| myconf="${myconf} --disable-inet6 --disable-netsec"

	econf \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		${myconf} || die "Configuration failed."

	use ssl && \
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die "patch failed"

	emake || die "Compilation failed."

}

src_install() {

	make DESTDIR="${D}" install || die	
	
	dohtml *.html

	dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README \
		README.NTLM README.SSL TODO COPYING MANIFEST
	
	doman /usr/share/man/*.1
	dosym /usr/share/man/fetchmailconf fetchmail.1
	
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
