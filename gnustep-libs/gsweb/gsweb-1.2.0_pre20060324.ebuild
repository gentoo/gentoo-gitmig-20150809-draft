# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gsweb/gsweb-1.2.0_pre20060324.ebuild,v 1.1 2006/03/26 11:45:57 grobian Exp $

inherit gnustep eutils subversion depend.apache

ESVN_OPTIONS="-r{${PV/*_pre}}"
ESVN_REPO_URI="http://svn.gna.org/svn/gnustep/libs/${PN}/trunk"
ESVN_STORE_DIR="${DISTDIR}/svn-src/svn.gna.org-gnustep/libs"

DESCRIPTION="GNUstepWeb: a library compatible with WebObjects 4.x"
HOMEPAGE="http://www.gnustep.org/"

KEYWORDS="~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="${GS_DEPEND}
	gnustep-libs/gdl2
	x11-libs/libPropList"
RDEPEND="${GS_RDEPEND}
	gnustep-libs/gdl2
	x11-libs/libPropList"
need_apache2

IUSE=""

egnustep_install_domain "System"

src_compile() {
	cd ${S}
	egnustep_env
	econf "--prefix=$(egnustep_prefix)" || die "./configure failed"
	egnustep_make || die
	cd ${S}/GSWAdaptors/Apache
	#pwd
	#einfo "emake -f GNUmakefile-Apache${APACHE_VERSION}x all"
	emake -f GNUmakefile-Apache${APACHE_VERSION}x all
	#ls -la
	cd ${S}
	#pwd
}

src_install() {
	egnustep_env
	gnustep_src_install
	cd ${S}/GSWAdaptors/Apache
	insinto ${APACHE2_MODULESDIR}
	insopts -m0755
	doins mod_gsweb.so
	cd ${S}

	insinto ${APACHE2_MODULES_CONFDIR}
	insopts -m0664
	doins ${FILESDIR}/${APACHE_VERSION}/42_mod_gsweb.conf

	dodir /etc/gsweb
	insinto /etc/gsweb
	insopts -m0664
	doins ${FILESDIR}/gsweb.conf

	dodir $(egnustep_system_root)/Library/Documentation/GSWeb
	insinto $(egnustep_system_root)/Library/Documentation/GSWeb
	doins GSWAdaptors/Doc/ConfigurationFile.html
}

pkg_postinst() {
	gnustep_pkg_postinst
	einfo "Edit /etc/conf.d/apache${APACHE_VERSION#1} and add \"-D GSWeb\" to APACHE${APACHE_VERSION#1}_OPTS"
}
