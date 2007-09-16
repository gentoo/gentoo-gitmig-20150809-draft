# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/libidn/libidn-0.6.9-r2.ebuild,v 1.1 2007/09/16 17:33:19 opfer Exp $

inherit autotools elisp-common java-pkg-opt-2 mono

DESCRIPTION="Internationalized Domain Names (IDN) implementation"
HOMEPAGE="http://www.gnu.org/software/libidn/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/libidn/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="java doc emacs mono nls"

DEPEND="java? ( >=virtual/jdk-1.4
				dev-java/gjdoc
				mono? ( >=dev-lang/mono-0.95 )
		)"
RDEPEND="java? ( >=virtual/jre-1.4 )
		mono? ( >=dev-lang/mono-0.95 )
		emacs? ( virtual/emacs )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/0.6.9-javacflags.patch"
	elibtoolize
	eautomake
}

src_compile() {
	local myconf=" --disable-csharp"

	use mono && myconf="--enable-csharp=mono"
	use emacs && myconf="${myconf} --with-lispdir="${SITELISP}/${PN}""

	econf \
		$(use_enable nls) \
		$(use_enable java) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO

	use emacs || rm -r "${D}/usr/share/emacs"

	if use doc; then
		dohtml -r doc/reference/html/*
	fi

	if use java; then
		java-pkg_newjar "${D}/usr/share/java/${P}.jar" || die "java-pkg_newjar failed"
		rm -rf "${D}/usr/share/java"

		if use doc; then
			java-pkg_dojavadoc doc/java
		fi
	fi
}

pkg_postinst() {
	if use emacs; then
		elog "activate Emacs support by adding the following lines to your ~/.emacs file"
		elog "   (add-to-list 'load-path \"${SITELISP}/${PN}\")"
		elog "   (load idna)"
		elog "   (load punycode)"
	fi
}
