# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/opencascade/opencascade-6.3-r3.ebuild,v 1.2 2011/03/07 22:51:38 dilfridge Exp $

EAPI=3

inherit autotools eutils check-reqs multilib java-pkg-opt-2

DESCRIPTION="Software development platform for CAD/CAE, 3D surface/solid modeling and data exchange"
HOMEPAGE="http://www.opencascade.org/"
SRC_URI="http://files.opencascade.com/OCC_${PV}_release/OpenCASCADE_src.tgz -> ${P}.tgz"

LICENSE="Open-CASCADE-Technology-Public-License-6.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples java"

DEPEND="
	virtual/opengl
	x11-libs/libXmu
	>=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	>=dev-tcltk/itcl-3.2
	>=dev-tcltk/itk-3.2
	>=dev-tcltk/tix-8.4.2
"
RDEPEND=${DEPEND}

S=${WORKDIR}/OpenCASCADE${PV}.0/ros

RESTRICT="bindist mirror"
# http://bugs.gentoo.org/show_bug.cgi?id=352435
# http://www.gentoo.org/foundation/en/minutes/2011/20110220_trustees.meeting_log.txt

pkg_setup() {
	java-pkg-opt-2_pkg_setup

	# Determine itk, itcl, tix, tk and tcl versions
	itk_version=$(grep ITK_VER /usr/include/itk.h | sed 's/^.*"\(.*\)".*/\1/')
	itcl_version=$(grep ITCL_VER /usr/include/itcl.h | sed 's/^.*"\(.*\)".*/\1/')
	tix_version=$(grep TIX_VER /usr/include/tix.h | sed 's/^.*"\(.*\)".*/\1/')
	tk_version=$(grep TK_VER /usr/include/tk.h | sed 's/^.*"\(.*\)".*/\1/')
	tcl_version=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')

	INSTALL_DIR=/usr/$(get_libdir)/${P}/ros

	ewarn " Please note that building OpenCascade takes a lot of time and "
	ewarn " hardware ressources: 3.5-4 GB free diskspace and 256 MB RAM are "
	ewarn " the minimum requirements. "

	# Check if we have enough RAM and free diskspace to build this beast
	CHECKREQS_MEMORY="256"
	CHECKREQS_DISK_BUILD="3584"
	check_reqs
}

src_prepare() {
	java-pkg-opt-2_src_prepare

	# Substitute with our ready-made env.ksh script
	cp -f "${FILESDIR}"/env.ksh.template env.ksh || die

	# Feed environment variables used by Opencascade compilation
	sed -i \
		-e "s:VAR_CASROOT:${S}:g" \
		-e 's:VAR_SYS_BIN:/usr/bin:g' \
		-e "s:VAR_SYS_LIB:/usr/$(get_libdir):g" env.ksh \
			|| die "Environment variables feed in env.ksh failed!"

	# Tweak itk, itcl, tix, tk and tcl versions
	sed -i \
		-e "s:VAR_ITK:itk${itk_version}:g" \
		-e "s:VAR_ITCL:itcl${itcl_version}:g" \
		-e "s:VAR_TIX:tix${tix_version}:g" \
		-e "s:VAR_TK:tk${tk_version}:g" \
		-e "s:VAR_TCL:tcl${tcl_version}:g" env.ksh \
			|| die "itk, itcl, tix, tk and tcl version tweaking failed!"

	epatch "${FILESDIR}"/${P}-fixed-DESTDIR.patch
	epatch "${FILESDIR}"/${P}-missing-mode.patch

	source env.ksh
	eautoreconf
}

src_configure() {
	# Add the configure options
	local confargs="--prefix=${INSTALL_DIR}/lin --exec-prefix=${INSTALL_DIR}/lin --with-tcl=/usr/$(get_libdir) --with-tk=/usr/$(get_libdir)"

	if use java ; then
		confargs+=" --with-java-include=$(java-config -O)/include"
	else
		confargs+=" --without-java-include"
	fi

	econf	${confargs} \
		$(use_enable debug ) $(use_enable !debug production ) \
			|| die "Configuration failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	# .la files kill cute little kittens
	find "${D}" -name '*.la' -exec rm {} +

	# Symlinks for keeping original OpenCascade folder structure and
	# add a link lib to $(get_libdir)  if we are e.g. on amd64 multilib
	if [ "$(get_libdir)" != "lib" ]; then
		dosym "$(get_libdir)" "${INSTALL_DIR}/lin/lib"
	fi

	# Tweak the environment variables script again with new destination
	cp "${FILESDIR}"/env.ksh.template env.ksh
	sed -i "s:VAR_CASROOT:${INSTALL_DIR}/lin:g" env.ksh

	# Build the env.d environment variables
	cp "${FILESDIR}"/env.ksh.template 50${PN}
	sed -i \
		-e 's:export ::g' \
		-e "s:VAR_CASROOT:${INSTALL_DIR}/lin:g" \
		-e '1,2d' \
		-e '4,14d' \
		-e "s:/Linux/lib/:/$(get_libdir)/:g" ./50${PN} \
			|| die "Creation of the /etc/env.d/50opencascade failed!"

	sed -i "2i\PATH=${INSTALL_DIR}/lin/bin\nLDPATH=${INSTALL_DIR}/lin/$(get_libdir)" ./50${PN} \
			|| die "Creation of the /etc/env.d/50opencascade failed!"

	# Update both env.d and script with the libraries variables
	sed -i \
		-e 's:VAR_SYS_BIN:/usr/bin:g' \
		-e "s:VAR_SYS_LIB:/usr/$(get_libdir):g" \
		-e "s:VAR_ITK:itk${itk_version}:g" \
		-e "s:VAR_ITCL:itcl${itcl_version}:g" \
		-e "s:VAR_TIX:tix${tix_version}:g" \
		-e "s:VAR_TK:tk${tk_version}:g" \
		-e "s:VAR_TCL:tcl${tcl_version}:g" env.ksh 50${PN} \
			|| die "Tweaking of the Tcl/Tk libraries location in env.ksh and 50opencascade failed!"

	# Install the env.d variables file
	doenvd 50${PN} || die

	cd "${S}"/../ || die

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r data || die

		insinto /usr/share/doc/${PF}/examples/samples
		doins -r samples/tutorial || die

		if use java ; then
			insinto /usr/share/doc/${PF}/examples/samples/standard
			doins -r samples/standard/java || die
		fi
	fi

	# Install the documentation
	if use doc; then
		cd "${S}"/../doc
		insinto /usr/share/doc/${PF}
		doins -r {Overview,ReferenceDocumentation} || die
	fi
}
