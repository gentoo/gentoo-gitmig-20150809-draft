# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mysql-connector-net/mysql-connector-net-6.2.3.ebuild,v 1.1 2010/07/14 11:28:23 ali_bush Exp $

EAPI="3"

inherit eutils multilib mono

DESCRIPTION="MySql ADO.NET connector"
HOMEPAGE="http://www.mysql.com/products/connector/net/"
SRC_URI="mirror://mysql/Downloads/Connector-Net/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples"

RDEPEND=">=dev-lang/mono-1.0"
DEPEND="${RDEPEND}
		app-arch/unzip
		dev-dotnet/nant
		>=dev-util/pkgconfig-0.20"

src_unpack() {
	mkdir -p "${S}"; cd "${S}";
	unpack ${A}
}

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"

	cp "${FILESDIR}/gentoo.snk" . || die
	sed -i '/AssemblyKeyName/d' \
		$(find MySql.Web MySql.Data MySql.Data.Entity -iname 'AssemblyInfo.cs')
	sed -i 's/release/Release/g' \
		$(find . -iname 'MySql.*.csproj')

	local line="[assembly: AssemblyKeyFile(@\"${S}/gentoo.snk\")]"
	echo "${line}" >> MySql.Web/Providers/Properties/AssemblyInfo.cs || die
	echo "${line}" >> MySql.Data/Provider/Properties/AssemblyInfo.cs || die
	echo "${line}" >> MySql.Data.Entity/Provider/Properties/AssemblyInfo.cs || die

	line="[assembly: AssemblyDelaySign(false)]"
	echo "${line}" >> MySql.Web/Providers/Properties/AssemblyInfo.cs || die
	echo "${line}" >> MySql.Data.Entity/Provider/Properties/AssemblyInfo.cs || die
}

src_compile() {
	xbuild MySQLClient-mono.sln || die "build failed"
}

src_install() {
	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" \
		-e "s:@LIBDIR@:$(get_libdir):" \
		"${FILESDIR}/02${PN}.pc.in" > "${D}/usr/$(get_libdir)/pkgconfig/${PN}.pc"

	# Install dll into the GAC
	ebegin "Installing dlls into the GAC"
	gacutil -i MySql.Data/Provider/bin/Release/MySql.Data.dll -root "${D}/usr/$(get_libdir)" \
		-gacdir /usr/$(get_libdir) -package ${PN} > /dev/null
	gacutil -i MySql.Web/Providers/bin/Release/MySql.Web.dll -root "${D}/usr/$(get_libdir)" \
		-gacdir /usr/$(get_libdir) -package ${PN} > /dev/null
	eend

	dodoc CHANGES README EXCEPTIONS

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r Samples
	fi
}

pkg_postinst() {
	elog "Adding the path for this connector in your mod_mono"
	elog "configuration may be needed:"
	elog "MonoPath \"/usr/$(get_libdir)/mono/${PN}/\""
}
