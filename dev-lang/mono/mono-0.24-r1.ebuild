# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mono/mono-0.24-r1.ebuild,v 1.1 2003/05/12 16:32:20 scandium Exp $

inherit eutils mono

MCS_P="mcs-${PV}"
MCS_S=${WORKDIR}/${MCS_P}

IUSE=""
DESCRIPTION="Mono runtime and class librarier, a C# compiler/interpreter"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz
	http://www.go-mono.com/archive/${MCS_P}.tar.gz"
HOMEPAGE="http://www.go-mono.com/"

LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="~x86 -ppc"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
	>=dev-libs/boehm-gc-6.1"

RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	# add our own little in-place mcs script
	echo "${S}/mono/mini/mono ${S}/runtime/mcs.exe \"\$@\" " > ${S}/runtime/mcs
	chmod +x ${S}/runtime/mcs
}

src_compile() {
	econf --with-gc=boehm || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die "MONO compilation failure"

	cd ${MCS_S}
	PATH=${S}/runtime:${S}/mono/mini:${PATH} MONO_PATH=${S}/runtime:${MONO_PATH} emake -f makefile.gnu || die "MCS compilation failure"
}

src_install () {
	cd ${S}
	einstall || die

	dodoc AUTHORS ChangeLog COPYING.LIB NEWS README
	docinto docs 
	dodoc docs/*

	# now install our own compiled dlls
	cd ${MCS_S}
	einstall || die

	# install mono's logo
	insopts -m0644
	insinto /usr/share/pixmaps/mono
	doins MonoIcon.png ScalableMonoIcon.svg

	docinto mcs
	dodoc AUTHORS COPYING README* ChangeLog INSTALL.txt
	docinto mcs/docs
	dodoc docs/*.txt

	# init script
	exeinto /etc/init.d ; newexe ${FILESDIR}/dotnet.init dotnet
	insinto /etc/conf.d ; newins ${FILESDIR}/dotnet.conf dotnet
}

pkg_postinst() {
	echo
	einfo "If you want to avoid typing '<runtime> program.exe'"
	einfo "you can configure your runtime in /etc/conf.d/dotnet"
	einfo "Use /etc/init.d/dotnet to register your runtime"
	echo
}
