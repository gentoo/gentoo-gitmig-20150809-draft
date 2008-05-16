# Copyright 2008-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/debhelper/debhelper-7.0.8.ebuild,v 1.1 2008/05/16 20:25:17 yvasilev Exp $

inherit eutils

DESCRIPTION="A collection of programs that can be used in a debian/rules file to automate common tasks related to building debian packages."
HOMEPAGE="http://packages.qa.debian.org/d/debhelper.html http://kitenet.net/~joey/code/debhelper.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls linguas_es linguas_fr"

RDEPEND="app-arch/dpkg
	dev-perl/TimeDate
	dev-lang/perl"

DEPEND="${RDEPEND}
	nls? ( >=app-text/po4a-0.24 )"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-conditional-nls.patch
}

src_compile() {
	local USE_NLS=no LANGS=""

	use nls && USE_NLS=yes

	use linguas_es && LANGS="${LANGS} es"
	use linguas_fr && LANGS="${LANGS} fr"

	emake USE_NLS=${USE_NLS} LANGS="${LANGS}" build \
		|| die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc doc/* debian/changelog
	docinto examples
	dodoc examples/*
	for manfile in *.1 *.7 ; do
		case ${manfile} in
			*.es.?)	use linguas_es \
					&& cp ${manfile} "${T}"/${manfile/.es/} \
					&& doman -i18n=es "${T}"/${manfile/.es/}
				;;
			*.fr.?)	use linguas_fr \
					&& cp ${manfile} "${T}"/${manfile/.fr/} \
					&& doman -i18n=fr "${T}"/${manfile/.fr/}
				;;
			*)	doman ${manfile}
				;;
		esac
	done
}
