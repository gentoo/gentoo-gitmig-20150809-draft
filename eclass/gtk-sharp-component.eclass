# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gtk-sharp-component.eclass,v 1.2 2004/11/19 03:08:42 latexer Exp $

# Author : Peter Johanson <latexer@gentoo.org>
# Based off of original work in gst-plugins.eclass by <foser@gentoo.org>

inherit eutils mono

ECLASS="gtk-sharp-component"
INHERITED="$INHERITED $ECLASS"

LICENSE="LGPL-2"

HOMEPAGE="http://gtk-sharp.sourceforge.net/"
LICENSE="LGPL-2.1"

###
# variable declarations
###

MY_P=gtk-sharp-${PV}

# From gtk-sharp-1.0 series
my_gtk_sharp_components="art gda glade gnome gnomedb gtkhtml rsvg vte"

# Added in gtk-sharp-2.0 series
my_gtk_sharp_components="${my_gtk_sharp_components} gnomevfs panelapplet"

# Version number used to differentiate between unversioned 1.0 series,
# and the versioned 2.0 series (2.0 series has 2 or 2.0 appended to various
# paths and scripts)
GTK_SHARP_COMPONENT_SLOT=""
GTK_SHARP_COMPONENT_SLOT_DEC=""

# Extract the component to build from the ebuild name
# May be set by an ebuild and contain more than one indentifier, space seperated
# (only src_configure can handle mutiple plugins at this time)
GTK_SHARP_COMPONENT_BUILD=${PN/-sharp/}

# Use to enable any other dependancies needed to build this package
GTK_SHARP_COMPONENT_BUILD_DEPS=""

# Actual build dir, is the same as the configure switch name most of the time
GTK_SHARP_COMPONENT_BUILD_DIR=${PN/-sharp/}

DESCRIPTION="${GTK_SHARP_COMPONENT_BUILD} plugin for gstreamer"
SRC_URI="mirror://sourceforge/gtk-sharp/${MY_P}.tar.gz
		mirror://gentoo/${MY_P}-configurable.diff.gz"

S=${WORKDIR}/${MY_P}

# Make sure we're building with the same version.
DEPEND="${DEPEND}
	=dev-dotnet/${MY_P}*
	sys-devel/automake
	sys-devel/autoconf
	>=sys-apps/sed-4"


###
# public functions
###

gtk-sharp-component_src_unpack() {
	GAPI_DIR="${ROOT}/usr/share/gapi${GTK_SHARP_COMPONENT_SLOT_DEC}"
	GAPI_FIXUP="gapi${GTK_SHARP_COMPONENT_SLOT}-fixup"
	GAPI_CODEGEN="gapi${GTK_SHARP_COMPONENT_SLOT}-codegen"
	GTK_SHARP_LIB_DIR="${ROOT}/usr/lib/mono/gtk-sharp${GTK_SHARP_COMPONENT_SLOT_DEC}"

	unpack ${A}
    cd ${S}

	# Make the components configurable
	epatch ${WORKDIR}/${MY_P}-configurable.diff
	aclocal || die
	automake || die
	autoconf || die

	# disable building of samples (#16015)
    sed -i -e "s:sample::" ${S}/Makefile.in || die

	cd ${S}/${GTK_SHARP_COMPONENT_BUILD_DIR}

	# Change references like "/r:../glib/glib-sharp.dll" ->
	# "/r:${GTK_SHARP_LIB_DIR}/glib-sharp.dll" and references like
	# "../glib/glib-sharp.xml" or "$(top_srcdir)/glib/glib-sharp.xml" ->
	# "${GAPI_DIR}/glib-sharp.xml"
	#
	# We also make sure to call the installed gapi-fixup and gapi-codegen
	# and not the ones that would be built locally
	for makefile in $(find . -name Makefile.in)
	do
		sed -i -e "s;/r:\(\.\./\)*[[:alpha:]]*/\([[:alpha:]]*-[[:alpha:]]*\).dll;/r:${GTK_SHARP_LIB_DIR}/\2.dll;g" \
			-e "s;\(\.\.\|\$(top_srcdir)\)/[[:alpha:]]*/\([[:alpha:]]*-[[:alpha:]]*\).xml;${GAPI_DIR}/\2.xml;g" \
			-e "s:\$(RUNTIME) \.\./parser/gapi-fixup.exe:${GAPI_FIXUP}:" \
			-e "s:\$(RUNTIME) \.\./generator/gapi_codegen.exe:${GAPI_CODEGEN}:" \
			-e "s: \.\./generator/gapi_codegen.exe::" \
			${makefile} || die "Failed to sed"
	done
}

gtk-sharp-component_src_configure() {
	
	# disable any external plugin besides the plugin we want
	local component deps gtk_sharp_conf

	einfo "Configuring to build ${PN} component ..."

	for component in ${GTK_SHARP_COMPONENT_BUILD} ${GTK_SHARP_COMPONENT_BUILD_DEPS}; do
		my_gtk_sharp_components=${my_gtk_sharp_components/${component}/}
	done
	for component in ${my_gtk_sharp_components}; do
		gtk_sharp_conf="${gtk_sharp_conf} --disable-${component} "
	done
	for component in ${GTK_SHARP_COMPONENT_BUILD} ${GTK_SHARP_COMPONENT_BUILD_DEPS}; do
		gtk_sharp_conf="${gtk_sharp_conf} --enable-${component} "
	done

	cd ${S}
	econf ${@} ${gtk_sharp_conf} || die "./configure failure"
}

gtk-sharp-component_src_compile() {
	gtk-sharp-component_src_configure ${@}

	cd ${S}/${GTK_SHARP_COMPONENT_BUILD_DIR}
	emake || die "compile failure"
}

gtk-sharp-component_src_install() {
	cd ${GTK_SHARP_COMPONENT_BUILD_DIR}
	make GACUTIL_FLAGS="/root ${D}/usr/lib /gacdir /usr/lib /package gtk-sharp${GTK_SHARP_COMPONENT_SLOT_DEC}" \
		DESTDIR=${D} install || die
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
