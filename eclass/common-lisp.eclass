# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/common-lisp.eclass,v 1.5 2004/02/12 15:14:03 mkennedy Exp $
#
# Author Matthew Kennedy <mkennedy@gentoo.org>
#
# This eclass supports the common-lisp-controller installation of many
# Common Lisp libraries

inherit common-lisp-common
ECLASS=common-lisp
INHERITED="$INHERITED $ECLASS"

CLPACKAGE=
newdepend "dev-lisp/common-lisp-controller"

pkg_postinst() {
	if [ -z "${CLPACKAGE}" ]; then
		die "CLPACKAGE was empty or undefined upon call to pkg_prerm"
	else
		for package in ${CLPACKAGE}; do
			einfo "Registering Common Lisp source for ${package}"
			register-common-lisp-source ${package}
		done
	fi
}

pkg_postrm() {
	if [ -z "${CLPACKAGE}" ]; then
		die "CLPACKAGE was empty or undefined upon call to pkg_prerm"
	else
		for package in ${CLPACKAGE}; do
			if [ ! -d ${CLSOURCEROOT}/${package} ]; then
				einfo "Unregistering Common Lisp source for ${package}"
				rm -rf ${CLFASLROOT}/*/${package}
#				unregister-common-lisp-source ${package}
			fi
		done
	fi
}

#
# In pkg_preinst, we remove the FASL files for the previous version of
# the source.
#
pkg_preinst() {
	if [ -z "${CLPACKAGE}" ]; then
		die "CLPACKAGE was empty or undefined upon call to pkg_preinst"
	else
		for package in ${CLPACKAGE}; do
			einfo "Removing FASL files for previous version of Common Lisp package ${package}"
			rm -rf ${CLFASLROOT}/*/${package} || true
		done
	fi
}

common-lisp-install() {
	insinto ${CLSOURCEROOT}/$CLPACKAGE
	doins $@
}

common-lisp-system-symlink() {
	dodir ${CLSYSTEMROOT}/`dirname ${CLPACKAGE}`
	if [ $# -eq 0 ]; then
		dosym ${CLSOURCEROOT}/${CLPACKAGE}/${CLPACKAGE}.asd \
			${CLSYSTEMROOT}/$CLPACKAGE.asd
	else
		for package in $@ ; do
			dosym ${CLSOURCEROOT}/$CLPACKAGE/${package}.asd \
				${CLSYSTEMROOT}/${package}.asd
		done
	fi
}

# Local Variables: ***
# mode: shell-script ***
# tab-width: 4 ***
# End: ***
