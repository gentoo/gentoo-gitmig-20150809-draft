# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java-pkg.eclass,v 1.16 2004/10/16 21:32:09 axxo Exp $

inherit base
ECLASS=java-pkg
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE}"
SLOT="${SLOT}"

java-pkg_doclass()
{
	debug-print-function ${FUNCNAME} $*
	java-pkg_dojar $*
}

java-pkg_do_init_() {
	debug-print-function ${FUNCNAME} $*

	if [ -z "${JARDESTTREE}" ] ; then
		JARDESTTREE="lib"
		SODESTTREE="lib"
	fi

	# Set install paths
	sharepath="${DESTTREE}/share"
	if [ "$SLOT" == "0" ] ; then
		pkg_name="${PN}"
	else
		pkg_name="${PN}-${SLOT}"
	fi

	shareroot="${sharepath}/${pkg_name}"
	jardest="${shareroot}/${JARDESTTREE}"
	sodest="/opt/${pkg_name}/${SODESTTREE}"
	package_env="${D}${shareroot}/package.env"

	debug-print "JARDESTTREE=${JARDESTTREE}"
	debug-print "SODESTTREE=${SODESTTREE}"
	debug-print "sharepath=${sharepath}"
	debug-print "shareroot=${shareroot}"
	debug-print "jardest=${jardest}"
	debug-print "sodest=${sodest}"
	debug-print "package_env=${package_env}"
}

java-pkg_do_write_() {
	# Create package.env
	echo "DESCRIPTION=${DESCRIPTION}" > "${package_env}"
	if [ -n "${cp_pkg}" ]; then
		echo "CLASSPATH=${cp_prepend}:${cp_pkg}:${cp_append}" >> "${package_env}"
	fi
	if [ -n "${lp_pkg}" ]; then
		echo "LIBRARY_PATH=${lp_prepend}:${lp_pkg}:${lp_append}" >> "${package_env}"
	fi
}

java-pkg_do_getsrc_() {
	# Check for symlink
	if [ -L "${i}" ] ; then
		cp "${i}" "${T}"
		echo "${T}"/`/usr/bin/basename "${i}"`

	# Check for directory
	elif [ -d "${i}" ] ; then
		echo "java-pkg: warning, skipping directory ${i}"
		continue
	else
		echo "${i}"
	fi
}


java-pkg_doso()
{
	debug-print-function ${FUNCNAME} $*
	[ -z "$1" ]

	java-pkg_do_init_

	# Check for arguments
	if [ -z "$*" ] ; then
		die "at least one argument needed"
	fi

	# Make sure directory is created
	if [ ! -d "${D}${sodest}" ] ; then
		install -d "${D}${sodest}"
	fi

	for i in $* ; do
		mysrc=$(java-pkg_do_getsrc_)

		# Install files
		install -m 0755 "${mysrc}" "${D}${sodest}" || die "${mysrc} not found"
	done
	lp_pkg="${sodest}"

	java-pkg_do_write_
}


java-pkg_dojar()
{
	debug-print-function ${FUNCNAME} $*
	[ -z "$1" ]

	java-pkg_do_init_

	if [ -n "${DEP_PREPEND}" ] ; then
		for i in ${DEP_PREPEND}
		do
			if [ -f "${sharepath}/${i}/package.env" ] ; then
				debug-print "${i} path: ${sharepath}/${i}"
				if [ -z "${cp_prepend}" ] ; then
					cp_prepend=`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				else
					cp_prepend="${cp_prepend}:"`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				fi
			else
				debug-print "Error:  Package ${i} not found."
				debug-print "${i} path: ${sharepath}/${i}"
				die "Error in DEP_PREPEND."
			fi
			debug-print "cp_prepend=${cp_prepend}"

		done
	fi

	if [ -n "${DEP_APPEND}" ] ; then
		for i in ${DEP_APPEND}
		do
			if [ -f "${sharepath}/${i}/package.env" ] ; then
				debug-print "${i} path: ${sharepath}/${i}"
				if [ -z "${cp_append}" ] ; then
					cp_append=`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				else
					cp_append="${cp_append}:"`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				fi
			else
				debug-print "Error:  Package ${i} not found."
				debug-print "${i} path: ${sharepath}/${i}"
				die "Error in DEP_APPEND."
			fi
			debug-print "cp_append=${cp_append}"
		done
	fi

	# Check for arguments
	if [ -z "$*" ] ; then
		die "at least one argument needed"
	fi

	# Make sure directory is created
	if [ ! -d "${D}${jardest}" ] ; then
		install -d "${D}${jardest}"
	fi

	for i in $* ; do
		mysrc=$(java-pkg_do_getsrc_)

		# Install files
		install -m 0644 "${mysrc}" "${D}${jardest}" || die "${mysrc} not found"

		# Build CLASSPATH
		if [ -z "${cp_pkg}" ] ; then
			cp_pkg="${jardest}"/`/usr/bin/basename "${i}"`
		else
			cp_pkg="${cp_pkg}:${jardest}/"`/usr/bin/basename "${i}"`
		fi
	done

	java-pkg_do_write_
}

java-pkg_dowar()
{
	debug-print-function ${FUNCNAME} $*
	[ -z "$1" ]

	# Check for arguments
	if [ -z "$*" ] ; then
		die "at least one argument needed"
	fi

	if [ -z "${WARDESTTREE}" ] ; then
		WARDESTTREE="webapps"
	fi

	sharepath="${DESTTREE}/share"
	shareroot="${sharepath}/${PN}"
	wardest="${shareroot}/${WARDESTTREE}"

	debug-print "WARDESTTREE=${WARDESTTREE}"
	debug-print "sharepath=${sharepath}"
	debug-print "shareroot=${shareroot}"
	debug-print "wardest=${wardest}"

	# Patch from Joerg Schaible <joerg.schaible@gmx.de>
	# Make sure directory is created
	if [ ! -d "${D}${wardest}" ] ; then
		install -d "${D}${wardest}"
	fi

	for i in $* ; do
		# Check for symlink
		if [ -L "${i}" ] ; then
			cp "${i}" "${T}"
			mysrc="${T}"/`/usr/bin/basename "${i}"`

		# Check for directory
		elif [ -d "${i}" ] ; then
			echo "dowar: warning, skipping directory ${i}"
			continue
		else
			mysrc="${i}"
		fi

		# Install files
		install -m 0644 "${mysrc}" "${D}${wardest}"
	done
}

java-pkg_dozip()
{
	debug-print-function ${FUNCNAME} $*
	java-pkg_dojar $*
}

java-pkg_jar-from()
{
	local pkg=$1
	local jar=$2
	local destjar=$3

	if [ -z "${destjar}" ] ; then
		destjar=${jar}
	fi

	for x in `java-config --classpath=${pkg} | tr ':' ' '`; do
		if [ ! -f ${x} ] ; then
			eerror "Installation problems with jars in ${pkg} - is it installed?"
			return 1
		fi
		if [ -z "${jar}" ] ; then
			ln -sf ${x} $(basename ${x})
		elif [ "`basename ${x}`" == "${jar}" ] ; then
			ln -sf ${x} ${destjar}
			return 0
		fi
	done
	if [ -z "${jar}" ] ; then
	        return 0
	else
		return 1
	fi
}

java-pkg_getjar() {
	local pkg=$1
	local jar=$2

	for x in $(java-config --classpath=${pkg} | tr ':' ' '); do
		if [ ! -f ${x} ] ; then
			die "Installation problems with jars in ${pkg} - is it installed?"
		elif [ "$(basename ${x})" == "${jar}" ] ; then
			echo ${x}
			return 0
		fi
	done
	die "Could not find $2 in $1"
}

java-pkg_getjars() {
	java-config --classpath=$1
}


java-pkg_dohtml() {
	dohtml -f package-list $@
}
