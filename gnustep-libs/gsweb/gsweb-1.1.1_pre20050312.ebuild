# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gsweb/gsweb-1.1.1_pre20050312.ebuild,v 1.1 2005/03/24 05:38:11 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/dev-libs/${PN}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs eutils depend.apache

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="GNUstepWeb is a library which was designed to be compatible with WebObjects 4.x (developed by NeXT (now Apple) Inc.)."
HOMEPAGE="http://www.gnustep.org"

KEYWORDS="~ppc"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="${GS_DEPEND}
	gnustep-libs/gdl2
	x11-libs/libPropList"
RDEPEND="${GS_RDEPEND}
	gnustep-libs/gdl2
	x11-libs/libPropList"
need_apache2

IUSE="${IUSE}"

egnustep_install_domain "System"

src_unpack() {
	cvs_src_unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PV}-build-fixes.patch
	cd ${S}
}

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

