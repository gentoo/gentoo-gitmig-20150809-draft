# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-0.28.ebuild,v 1.6 2004/10/29 17:08:48 latexer Exp $

inherit mono

MCS_P="mcs-${PV}"
MCS_S=${WORKDIR}/${MCS_P}

DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz
	http://www.go-mono.com/archive/${MCS_P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 X11)"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND="virtual/libc
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
	emake -j1 || die "MONO compilation failure"

	ln -s ../runtime ${WORKDIR}/${P}/runtime/lib
	cd ${MCS_S}
	echo "prefix=${S}/runtime" > build/config.make
	echo "MONO_PATH=${S}/runtime" >> build/config.make
	echo "BOOTSTRAP_MCS=${S}/runtime/mcs" >> build/config.make
	echo "RUNTIME=${S}/mono/mini/mono \${RUNTIME_FLAGS}" >> build/config.make
	echo "export MONO_PATH" >> build/config.make
	make || die "MCS compilation failure"
	echo "prefix=/usr" >> build/config.make
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS README
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
	dodoc AUTHORS README* ChangeLog INSTALL.txt
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
