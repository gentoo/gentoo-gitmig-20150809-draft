# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-0.26.ebuild,v 1.2 2003/08/26 17:03:44 scandium Exp $

inherit eutils mono

MCS_P="mcs-${PV}"
MCS_S=${WORKDIR}/${MCS_P}

IUSE=""
DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz
	http://www.go-mono.com/archive/${MCS_P}.tar.gz"
HOMEPAGE="http://www.go-mono.com/"

LICENSE="GPL-2 | LGPL-2 | X11"
SLOT="0"

KEYWORDS="~x86 -ppc"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
	!dev-dotnet/pnet"

RDEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-libs/libxml2
	dev-libs/libxslt"

src_unpack() {
	unpack ${A}

	# add our own little in-place mcs script
	echo "${S}/mono/mini/mono ${S}/runtime/mcs.exe \"\$@\" " > ${S}/runtime/mcs
	chmod +x ${S}/runtime/mcs
}

src_compile() {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die "MONO compilation failure"

	#disable building of mcs for now, see bug 26839
	#cd ${MCS_S}
	#PATH=${S}/runtime:${S}/mono/mini:${PATH} MONO_PATH=${S}/runtime:${MONO_PATH} make MCS=${S}/runtime/mcs || die "MCS compilation failure"
}

src_install () {
	cd ${S}
	einstall || die

	dodoc AUTHORS ChangeLog COPYING.LIB NEWS README
	docinto docs 
	dodoc docs/*

	# now install our own compiled dlls (disabled for now, mcs build problems)
	#cd ${MCS_S}
	#einstall || die

	# install mono's logo
	#insopts -m0644
	#insinto /usr/share/pixmaps/mono
	#doins MonoIcon.png ScalableMonoIcon.svg

	#docinto mcs
	#dodoc AUTHORS COPYING README* ChangeLog INSTALL.txt
	#docinto mcs/docs
	#dodoc docs/*.txt

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
