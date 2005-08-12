# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchmail/fetchmail-6.2.5-r2.ebuild,v 1.6 2005/08/12 21:34:43 ferdy Exp $

inherit eutils gnuconfig

DESCRIPTION="the legendary remote-mail retrieval and forwarding utility"
HOMEPAGE="http://www.catb.org/~esr/fetchmail/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="ssl nls ipv6 kerberos krb4 hesiod"

RDEPEND="hesiod? ( net-dns/hesiod )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	kerberos? ( app-crypt/mit-krb5 )
	sys-devel/gettext
	elibc_FreeBSD? ( sys-libs/com_err )"

DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-6.2.0-gentoo.diff || die
	epatch ${FILESDIR}/${P}-kerberos.patch
	# patch fixes bug #40126 (tomk@gentoo.org 2004-08-07)
	epatch ${FILESDIR}/${P}-fetchsizelimit.patch || die
	# this patch fixes bug #34788 (ticho@gentoo.org 2004-09-03)
	epatch ${FILESDIR}/${P}-broken-headers.patch || die
	# this patch fixes bug #97263 (ticho@gentoo.org 2005-06-01)
	if has_version '>=app-crypt/mit-krb5-1.4' ; then
		epatch ${FILESDIR}/${P}-mit-krb5-1.4.patch || die
	fi

	autoconf
	gnuconfig_update
}

src_compile() {
	econf  --disable-dependency-tracking \
		--enable-RPA \
		--enable-NTLM \
		--enable-SDPS \
		$(use_enable nls) \
		$(use_enable ipv6 inet6) \
		$(use_with kerberos gssapi) $(use_with kerberos kerberos5) \
		$(use_with krb4 kerberos) \
		$(use_with ssl) \
		$(use_with hesiod) \
		${myconf} || die "Configuration failed."
	# wont compile reliably on smp (mkennedy@gentoo.org 2003-11-12)
	make || die "Compilation failed."
}

src_install() {
	einstall || die

	dohtml *.html

	dodoc FAQ FEATURES ABOUT-NLS NEWS NOTES README \
		README.NTLM README.SSL TODO COPYING MANIFEST

	doman ${D}/usr/share/man/*.1
	rm -f ${D}/usr/share/man/*.1

	newinitd ${FILESDIR}/fetchmail fetchmail
	newconfd ${FILESDIR}/conf.d-fetchmail fetchmail

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

	einfo "Please see /etc/conf.d/fetchmail if you want to adjust"
	einfo "the polling delay used by the fetchmail init script."
}
