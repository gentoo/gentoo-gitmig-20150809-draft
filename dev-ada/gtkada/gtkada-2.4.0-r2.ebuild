# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/gtkada/gtkada-2.4.0-r2.ebuild,v 1.1 2006/06/12 19:38:43 george Exp $

inherit eutils gnat

Name="GtkAda"
DESCRIPTION="Gtk+ bindings to the Ada language"
HOMEPAGE="https://libre2.adacore.com/GtkAda/"
SRC_URI="https://libre2.adacore.com/${Name}/${Name}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="nls opengl"

DEPEND="virtual/gnat
	>=x11-libs/gtk+-2.2.0
	>=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/${Name}-${PV}"

# a location to temporarily keep common stuff installed by make install
CommonInst="${WORKDIR}/common-install"

src_unpack() {
	gnat_src_unpack

	cd ${S}
	sed -i -e "s|-I\$prefix/include|-I${AdalibSpecsDir}|" \
		src/gtkada-config.in

}

lib_compile() {
	# some profile specific fixes first
	sed -i -e "s|-L\$prefix/include|-L${AdalibLibTop}/$1|" \
		src/gtkada-config.in

	# ATTN! Check if this is fixed when new version comes out!
	# this one fails on 4.1 without and 3.4 with..
	if [[ $(get_gnat_SLOT $1) > 3.4 ]] ; then
		epatch ${FILESDIR}/${P}.patch
	fi

	local myconf
	use opengl && myconf="--with-GL=auto" || myconf="--with-GL=no"

	econf ${myconf} $(use_enable nls) || die "./configure failed"

	make GNATFLAGS="${ADACFLAGS}" || die
}

lib_install() {
	make prefix=${DL} \
		incdir=${DL}/adainclude \
		libdir=${DL}/adalib \
		alidir=${DL}/adalib \
		install || die

	# move common stuff out of $DL
	if [[ -d "${CommonInst}" ]] ; then
		# we need only one copy, its all identical
		mv "${DL}"/adainclude/gtkada-mdi.adb "${DL}"
		rm -rf "${DL}"/{adainclude/*,doc,projects,share}
		mv "${DL}"/gtkada-mdi.adb "${DL}"/adainclude/
	else
		mkdir "${CommonInst}"
		mv ${DL}/{adainclude,doc,projects,share} "${CommonInst}"
		# one .adb file has profile-specific fixes..
		mkdir "${DL}"/adainclude
		mv "${CommonInst}"/adainclude/gtkada-mdi.adb "${DL}"/adainclude/
	fi
}

src_install() {
	#set up environment
	echo "PATH=%DL%/bin" > ${LibEnv}
	echo "LDPATH=%DL%/adalib" >> ${LibEnv}
	echo "ADA_OBJECTS_PATH=%DL%/adalib" >> ${LibEnv}
	echo "ADA_INCLUDE_PATH=%DL%/adainclude:/usr/lib/ada/adainclude/${PN}" >> ${LibEnv}

	gnat_src_install

	#specs
	cd "${CommonInst}"
	dodir "${AdalibSpecsDir}/${PN}"
	insinto "${AdalibSpecsDir}/${PN}"
	doins "${CommonInst}"/adainclude/*

	#docs
	cd ${S}
	dodoc ANNOUNCE AUTHORS COPYING README
	cd "${CommonInst}"
	cp -dPr doc/${Name}/* share/${PN}/examples/ "${D}/usr/share/doc/${PF}"
}

pkg_postinst() {
	eselect gnat update
	einfo "The environment has been set up to make gnat automatically find files for"
	einfo "GtkAda. In order to immediately activate these settings please do:"
	einfo "   env-update && source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}

