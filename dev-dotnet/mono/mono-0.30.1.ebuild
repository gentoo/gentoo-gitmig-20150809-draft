# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-0.30.1.ebuild,v 1.1 2004/02/14 21:54:00 tberman Exp $

inherit mono flag-o-matic

strip-flags

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
	>=dev-libs/icu-2.6
	!dev-dotnet/pnet"

RDEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}

	# add our own little in-place mcs script
	echo "${S}/mono/mini/mono ${S}/runtime/mcs.exe \"\$@\" " > ${S}/runtime/mcs
	chmod +x ${S}/runtime/mcs

	echo "${S}/mono/mini/mono ${S}/runtime/monoresgen.exe \"\$@\" " > ${S}/runtime/monoresgen
	chmod +x ${S}/runtime/monoresgen

	PATH="${PATH}:${S}/runtime"
	export PATH
}

src_compile() {
	econf || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die "MONO compilation failure"

	ln -s ../runtime ${WORKDIR}/${P}/runtime/lib
	cd ${MCS_S}
	echo "prefix=${S}/runtime" > build/config.make
	echo "MONO_PATH=${S}/runtime" >> build/config.make
	echo "BOOTSTRAP_MCS=${S}/runtime/mcs" >> build/config.make
	echo "RUNTIME=${S}/mono/mini/mono \${RUNTIME_FLAGS}" >> build/config.make
	echo "PATH=${PATH}:${S}/runtime" >> build/config.make
	echo "export PATH" >> build/config.make
	echo "export MONO_PATH" >> build/config.make
	make || die "MCS compilation failure"
	echo "prefix=/usr" >> build/config.make
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
