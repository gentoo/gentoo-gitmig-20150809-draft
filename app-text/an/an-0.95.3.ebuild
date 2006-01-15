# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/an/an-0.95.3.ebuild,v 1.9 2006/01/15 12:54:48 yoswink Exp $

inherit eutils toolchain-funcs versionator

DESCRIPTION="Very fast anagram generator with dictionary lookup"
HOMEPAGE="http://packages.debian.org/stable/games/an"

MY_PV="$(get_version_component_range 1-2)"
SRC_URI="mirror://debian/pool/main/a/an/${PN}_${MY_PV}.orig.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="sys-apps/miscfiles"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patching to -r3:
	MY_PL="$(replace_version_separator 2 -)"
	epatch "${FILESDIR}"/${PN}_${MY_PL}.diff

	ebegin "Patching an to use toolchain and custom CFLAGS"
	sed -e "s:gcc:$(tc-getCC):" \
		-e "s:-O2.*:${CFLAGS}:" \
		-i Makefile lib/Makefile
	eend ${?}

	# sys-apps/miscfiles doesn't have /usr/dict/words:
	sed \
		-e 's:/usr/dict/words:/usr/share/dict/words:' \
		-i README || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.6 || die
	dodoc \
		debian/changelog \
		debian/README.Debian \
		DICTIONARY \
		EXAMPLE.ANAGRAMS \
		HINTS \
		INSTALL \
		README \
		TODO || die
}

pkg_postinst() {
	if has_version sys-apps/miscfiles && \
		built_with_use sys-apps/miscfiles minimal; then
		ewarn "If you merged sys-apps/miscfiles with USE=minimal,"
		ewarn "an will NOT work properly, as /usr/share/dict/words"
		ewarn "will then be a symlink to a gzipped file. an currently"
		ewarn "does not support gzipped dictionary files and will"
		ewarn "only produce garbage."
		ewarn "Do 'USE=-minimal emerge sys-apps/miscfiles', or run an"
		ewarn "with the -d /path/to/dictionary option, perhaps using"
		ewarn "one of the files mentioned below."
		echo
	fi

	einfo "Helpful note from an's author:"
	einfo "   If you do not have a dictionary you can obtain one from the"
	einfo "   following site: ftp://ftp.funet.fi/pub/doc/dictionaries/"
	einfo "   You will find a selection of dictionaries in many different"
	einfo "   languages here."
}
