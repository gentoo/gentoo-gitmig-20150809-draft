# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/alpine/alpine-2.00-r4.ebuild,v 1.1 2010/09/09 06:07:48 tove Exp $

EAPI="2"

inherit eutils flag-o-matic

# http://staff.washington.edu/chappa/alpine/patches/${P}/log.txt
CHAPPA_PL="73"

DESCRIPTION="alpine is an easy to use text-based based mail and news client"
HOMEPAGE="http://www.washington.edu/alpine/ http://staff.washington.edu/chappa/alpine/"
SRC_URI="ftp://ftp.cac.washington.edu/alpine/${P}.tar.bz2
	chappa? ( http://staff.washington.edu/chappa/alpine/patches/${P}/all.patch.gz -> ${P}-chappa-${CHAPPA_PL}-all.patch.gz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="+chappa doc ipv6 kerberos ldap nls onlyalpine passfile smime spell ssl threads topal"

DEPEND="virtual/pam
	>=sys-libs/ncurses-5.1
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )
	spell? ( app-text/aspell )
	topal? ( >=net-mail/topal-72 )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	!onlyalpine? ( !app-editors/pico )
	!onlyalpine? ( !mail-client/pine )
	!<=net-mail/uw-imap-2004g"

maildir_warn() {
	elog
	elog "This build of ${PN} has Maildir support built in as"
	elog "part of the chappa-all patch."
	elog
	elog "If you have a maildir at ~/Maildir it will be your"
	elog "default INBOX. The path may be changed with the"
	elog "\"maildir-location\" setting in alpine."
	elog
	elog "To use /var/spool/mail INBOX again, set"
	elog "\"disable-these-drivers=md\" in your .pinerc file."
	elog
	elog "Alternately, you might want to read following webpage, which explains how to"
	elog "use multiple mailboxes simultaneously:"
	elog
	elog "http://www.math.washington.edu/~chappa/pine/pine-info/collections/incoming-folders/"
	elog
}

pkg_setup() {
	if use smime && use topal ; then
		ewarn "You can not have USE='smime topal'. Assuming topal is more important."
	fi
}

src_unpack() {
	unpack ${P}.tar.bz2
}

src_prepare() {
	use chappa && epatch "${DISTDIR}"/${P}-chappa-${CHAPPA_PL}-all.patch.gz
	use topal && epatch /usr/share/topal/patches/${P}.patch-{1,2}

	epatch "${FILESDIR}"/2.00-lpam.patch
	cd "${S}/imap/src/c-client"
	epatch "${FILESDIR}"/CVE-2008-5514.patch
}

src_configure() {
	local myconf="--without-tcl
		--with-system-pinerc=/etc/pine.conf
		--with-system-fixed-pinerc=/etc/pine.conf.fixed
		--with-ssl-certs-dir=/etc/ssl/certs"
		# fixme
		#   --with-system-mail-directory=DIR?
	econf $(use_with ssl) \
		$(use_with ldap) \
		$(use_with passfile passfile .pinepwd) \
		$(use_with kerberos krb5) \
		$(use_with threads pthread) \
		$(use_with spell interactive-spellcheck /usr/bin/aspell) \
		$(use_enable nls) \
		$(use_with ipv6) \
		$(use topal || use_with smime) \
		${myconf}
}

src_install() {
	if use onlyalpine ; then
		dobin alpine/alpine || die
		doman doc/alpine.1 || die
	else
		emake DESTDIR="${D}" install || die
		doman doc/rpdump.1 doc/rpload.1 || die
	fi

	dodoc NOTICE || die
	if use chappa ; then
		dodoc README.maildir || die
	fi

	if use doc ; then
		dodoc README doc/brochure.txt doc/tech-notes.txt || die
		docinto imap
		dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/RELNOTES || die

		docinto imap/rfc
		dodoc imap/docs/rfc/*.txt || die

		docinto html/tech-notes
		dohtml -r doc/tech-notes/ || die
	fi
}

pkg_postinst() {
	use chappa && maildir_warn
	if use spell ; then
		elog
		elog "In order to use spell checking"
		elog "  emerge app-dicts/aspell-\<your_langs\>"
		elog "and setup alpine with:"
		elog "  Speller = /usr/bin/aspell -c"
		elog
	fi
	if use topal ; then
		elog
		elog "In order to use gpg with topal"
		elog "  read /usr/doc/topal/README.txt"
		elog
	fi
	if use passfile ; then
		elog
		elog "${PN} will cache passwords between connections."
		elog "File ~/.pinepwd will be used for this."
		elog
	fi
}
