# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mysql-connector-net/mysql-connector-net-1.0.9.ebuild,v 1.1 2007/06/25 00:10:09 jurek Exp $

inherit eutils multilib mono

DESCRIPTION="MySql ADO.NET connector"
HOMEPAGE="http://www.mysql.com/products/connector/net/"
SRC_URI="mirror://mysql/Downloads/Connector-Net/${P}-noinstall.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

DEPEND=">=dev-lang/mono-1.0
		dev-dotnet/nant
		app-arch/unzip"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir ${WORKDIR}/${P}; cd ${WORKDIR}/${P};
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}.patch || die

	sed -i 's:AssemblyKeyFile.*:AssemblyKeyFile(\@\"'${S}'\/\'${PN}'.key")]:' mysqlclient/AssemblyInfo.cs
}

src_compile() {
	# Generate signing key
	ebegin "Generating a signed key"
		/usr/bin/sn -k ${PN}.key > /dev/null
	eend

	# Make dll
	/usr/bin/nant -t:mono-1.0 || die "build failed"
}

src_install() {
	# Install dll into the GAC
	ebegin "Installing dlls into the GAC"
	gacutil -i mysqlclient/bin/mono-1.0/release/MySql.Data.dll -root ${D}/usr/$(get_libdir) \
		-gacdir /usr/$(get_libdir) -package ${PN} > /dev/null
	eend

	dodoc CHANGES README EXCEPTIONS

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins doc/MySql.Data.chm
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r Samples
	fi
}

pkg_postinst() {
	elog "Adding the path for this connector in your mod_mono"
	elog "configuration may be needed:"
	elog "MonoPath \"/usr/lib/mono/1.0/${PN}/\""
}
