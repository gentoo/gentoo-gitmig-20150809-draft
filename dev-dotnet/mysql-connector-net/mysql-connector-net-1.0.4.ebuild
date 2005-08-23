# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mysql-connector-net/mysql-connector-net-1.0.4.ebuild,v 1.3 2005/08/23 19:54:55 ramereth Exp $

inherit eutils multilib mono

DESCRIPTION="MySql ADO.NET connector"
HOMEPAGE="http://www.mysql.com/products/connector/net/"
SRC_URI="mirror://mysql/Downloads/Connector-Net/${P}-noinstall.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc"
RESTRICT="nomirror"

DEPEND=">=dev-lang/mono-1.0
		dev-dotnet/nant"

src_unpack() {
	mkdir ${WORKDIR}/${P}; cd ${WORKDIR}/${P};
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/mysql-connector-net-1.0.4-fixes.patch \
	${FILESDIR}/mysql-connector-net-1.0.4-assembly.patch || die
	sed -i 's:AssemblyKeyFile.*:AssemblyKeyFile(\@\"'${S}'\/\'${PN}'.key")]:' mysqlclient/AssemblyInfo.cs
}

src_compile() {
	# Generate signing key
	ebegin "Generating a signed key"
	sn -k ${PN}.key > /dev/null
	eend
	# Make dll
	nant -t:mono-1.0 || die
}

src_install() {
	# Install dll into the GAC
	ebegin "Installing dlls into the GAC"
	gacutil -i bin/mono-1.0/release/MySql.Data.dll -root ${D}/usr/$(get_libdir) \
		-gacdir /usr/$(get_libdir) -package ${PN} > /dev/null
	eend

	dodoc CHANGES README EXCEPTIONS

	if use doc; then
		dodir /usr/share/doc/${PF}/samples
		cp -pPR Samples/* ${D}/usr/share/doc/${PF}/samples/
	fi
}

pkg_postinst() {
	einfo "Adding the path for this connector in your mod_mono"
	einfo "configuration may be needed:"
	einfo "MonoPath \"/usr/lib/mono/1.0/mysql-connector-net/\""
}
