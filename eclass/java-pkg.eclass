# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java-pkg.eclass,v 1.1 2003/04/26 11:29:16 absinthe Exp $

inherit base
ECLASS=java-pkg
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE}"
SLOT="${SLOT}"

java-pkg_dojar()
{
	debug-print-function ${FUNCNAME} $*
	[ -z "$1" ]
	
	if [ -z "${JARDESTTREE}" ] ; then
		JARDESTTREE="lib"
	fi
	
	sharepath="${DESTTREE}/share"
	shareroot="${sharepath}/${PN}"
	jardest="${shareroot}/${JARDESTTREE}"
	package_env="${D}${shareroot}/package.env"
	#dodir "${jardest}"

	debug-print "JARDESTTREE=${JARDESTTREE}"
	debug-print "sharepath=${sharepath}"
	debug-print "shareroot=${shareroot}"
	debug-print "jardest=${jardest}"
	debug-print "package_env=${package_env}"


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
		echo "${0}: at least one argument needed"
		exit 1
	fi

	# Make sure direcotry is created
	if [ ! -d "${D}${jardest}" ] ; then
		install -d "${D}${jardest}"
	fi

	for i in $* ; do
		# Check for symlink
		if [ -L "${i}" ] ; then
			cp "${i}" "${T}"
			mysrc="${T}"/`/usr/bin/basename "${i}"`

		# Check for directory
		elif [ -d "${i}" ] ; then
			echo "dojar: warning, skipping directory ${i}"
			continue
		else
			mysrc="${i}"
		fi

		# Iinstall files
		install -m 0644 "${mysrc}" "${D}${jardest}"

		# Build CLASSPATH
		if [ -z "${cp_pkg}" ] ; then
			cp_pkg="${jardest}"/`/usr/bin/basename "${i}"`
		else
			cp_pkg="${cp_pkg}:${jardest}/"`/usr/bin/basename "${i}"`
		fi
	done
	
	# Create package.env
	echo "DESCRIPTION=${DESCRIPTION}" > "${package_env}"
	echo "CLASSPATH=${cp_prepend}:${cp_pkg}:${cp_append}" >> "${package_env}"
}
