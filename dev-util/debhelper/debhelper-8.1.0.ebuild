# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debhelper/debhelper-8.1.0.ebuild,v 1.1 2011/02/07 08:04:31 yvasilev Exp $

inherit eutils

DESCRIPTION="Collection of programs that can be used to automate common tasks in debian/rules"
HOMEPAGE="http://packages.qa.debian.org/d/debhelper.html http://kitenet.net/~joey/code/debhelper.html"
SRC_URI="http://launchpad.net/${PN}/main/${PV}/+download/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="nls linguas_es linguas_fr test"

RDEPEND="app-arch/dpkg
	dev-perl/TimeDate
	virtual/perl-Getopt-Long
	>=dev-lang/perl-5.10"

DEPEND="${RDEPEND}
	nls? ( >=app-text/po4a-0.24 )
	test? ( dev-perl/Test-Pod )"

S="${WORKDIR}"/${PN}

PATCH_VER=7.4.13

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-${PATCH_VER}-conditional-nls.patch

	# Romove broken test
	rm -f t/override_target
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
