# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono/mono-0.91.ebuild,v 1.5 2004/06/02 20:58:44 dholm Exp $

inherit eutils mono flag-o-matic

strip-flags

MCS_P="mcs-${PV}"
MCS_S=${WORKDIR}/${MCS_P}

IUSE="nptl"
DESCRIPTION="Mono runtime and class libraries, a C# compiler/interpreter"
SRC_URI="http://www.go-mono.com/archive/beta1/${P}.tar.gz"
HOMEPAGE="http://www.go-mono.com/"

LICENSE="GPL-2 | LGPL-2 | X11"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.0
	>=dev-libs/icu-2.6.1
	!dev-dotnet/pnet
	ppc? ( >=sys-devel/gcc-3.2.3-r4 )
	ppc? ( >=sys-libs/glibc-2.3.3_pre20040420 )"

RDEPEND="${DEPEND}
	dev-util/pkgconfig
	dev-libs/libxml2"

src_compile() {
	local myconf=""
	if use nptl && have_NPTL
	then
		myconf="${myconf} --with-nptl=yes"
	else
		myconf="${myconf} --with-nptl=no"
	fi

	econf ${myconf} || die
	MAKEOPTS="${MAKEOPTS} -j1" emake || die "MONO compilation failure"
}

src_install () {
	cd ${S}
	einstall || die

	dodoc AUTHORS ChangeLog COPYING.LIB NEWS README
	docinto docs
	dodoc docs/*

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
