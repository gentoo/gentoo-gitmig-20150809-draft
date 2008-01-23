# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crm114/crm114-20041231.ebuild,v 1.7 2008/01/23 03:26:03 steev Exp $

inherit eutils

IUSE="nls static normalizemime mew mimencode"

MY_P="${P}.BlameSanAndreas.src"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A powerful text processing tool, mainly used for spam filtering"
HOMEPAGE="http://crm114.sourceforge.net/"
SRC_URI="http://crm114.sourceforge.net/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~x86"

TREVERS="0.7.2"

DEPEND=">=sys-apps/sed-4
	virtual/libc
	mail-filter/procmail
	normalizemime? ( mail-filter/normalizemime )
	mew? ( app-emacs/mew )
	mimencode? ( net-mail/metamail )
	!static? ( >=dev-libs/tre-${TREVERS} )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "s#^CFLAGS.*#CFLAGS+=${CFLAGS} -I.#" Makefile

	if use static ; then
		sed -i "s#-ltre#-L${S}/${TREVERS}/lib/.libs/ -ltre#g" Makefile
	else
		sed -i "s#-static##g"  Makefile
	fi
	sed -i "s#ln -f -s crm114_tre crm114##" Makefile

	if use mimencode ; then
		einfo "Using mimencode -- adjusting mailfilter.cf"
		sed -i 's%#:mime_decoder: /mimencode -u/%:mime_decoder: /mimencode -u/%' \
			mailfilter.cf
		sed -i 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf
	elif use normalizemime ; then
		einfo "Using normalizemime -- adjusting mailfilter.cf"
		sed -i 's%#:mime_decoder: /normalizemime/%:mime_decoder: /normalizemime/%' mailfilter.cf

		sed -i 's%:mime_decoder: /mewdecode/%#:mime_decoder: /mewdecode/%' \
			mailfilter.cf
	fi

	cd "${S}"/tre-${TREVERS}
	chmod +x configure
}

src_compile() {
	# Build TRE library.
	if use static ; then
		cd "${S}"/tre-${TREVERS}
		econf \
			$(use_enable nls) \
			$(use_enable static) \
			--enable-system-abi \
			--disable-profile \
			--disable-agrep \
			--disable-debug || die
		emake || die
	fi

	# Build crm114
	cd "${S}"
	emake || die
}

src_install() {
	dobin crm114_tre cssutil cssdiff cssmerge
	dobin osbf-util
	dosym crm114_tre /usr/bin/crm114
	dosym crm114_tre /usr/bin/crm

	dodoc COLOPHON.txt CRM114_Mailfilter_HOWTO.txt FAQ.txt INTRO.txt
	dodoc QUICKREF.txt classify_details.txt inoc_passwd.txt
	dodoc knownbugs.txt things_to_do.txt README
	docinto examples
	dodoc *.example
	dodoc procmail.recipe

	insinto /usr/share/${PN}
	doins *.crm
	doins *.cf
	doins *.mfp
}

pkg_postinst() {
	echo
	elog "The spam-filter CRM files are installed in /usr/share/${PN}."
	echo
}
