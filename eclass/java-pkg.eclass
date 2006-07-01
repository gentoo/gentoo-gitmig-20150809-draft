# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java-pkg.eclass,v 1.38 2006/07/01 20:28:43 nichoj Exp $

inherit multilib

EXPORT_FUNCTIONS pkg_setup

# We need to do a few things to add compatibility between
# generation-1 and generation-2.

# First we make sure java-config-1 will be used
export WANT_JAVA_CONFIG="1"

# VMHANDLE is defined in /etc/env.d/20java. This is the handle java-config-2
# uses for determining which VM to use.
#
# We set GENTOO_VM to this, to ensure that /usr/bin/java and company are using
# the right VM.
export GENTOO_VM="${VMHANDLE}"

# During pkg_setup, we need to live some crumb trails that we're using
# in a mixed generation-1/generation-2 environment
# TODO need to make sure everything that inherits java-pkg and has a pkg_setup
# uses java-pkg_pkg_setup
java-pkg_pkg_setup() {
	java-pkg_announce-qa-violation "using deprecated eclass java-pkg"
	
	# We need to do a little magic if java-config-2 is around
	if has_version "=dev-java/java-config-2*"; then
		ebegin "Enabling generation-2 compatibility"
		if [[ -n ${GENTOO_VM} ]]; then
			einfo "Using ${GENTOO_VM}"
			eend 0
		else
			eerror "There was a problem determining which VM to use for generation-1"
			eerror "You may need to set your generation-1 VM again, and run env-update && source/etc/profile"
			eerror "Also, make sure you have followed the Java Upgrade Guide:"
			eerror "http://www.gentoo.org/proj/en/java/java-upgrade.xml"
			eend 1
			die "Couldn't determine VM for generation-1"
		fi
	fi
}


pkglistpath="${T}/java-pkg-list"

java-pkg_doclass()
{
	debug-print-function ${FUNCNAME} $*
	java-pkg_dojar $*
}

java-pkg_do_init_()
{
	debug-print-function ${FUNCNAME} $*

	if [ -z "${JARDESTTREE}" ] ; then
		JARDESTTREE="lib"
		SODESTTREE=$(get_libdir)
	fi

	# Set install paths
	sharepath="${DESTTREE}/share"
	if [ "$SLOT" == "0" ] ; then
		pkg_name="${PN}"
	else
		pkg_name="${PN}-${SLOT}"
	fi

	shareroot="${sharepath}/${pkg_name}"

	if [ -z "${jardest}" ] ; then
		jardest="${shareroot}/${JARDESTTREE}"
	fi

	if [ -z "${sodest}" ] ; then
		sodest="/opt/${pkg_name}/${SODESTTREE}"
	fi

	package_env="${D}${shareroot}/package.env"

	debug-print "JARDESTTREE=${JARDESTTREE}"
	debug-print "SODESTTREE=${SODESTTREE}"
	debug-print "sharepath=${sharepath}"
	debug-print "shareroot=${shareroot}"
	debug-print "jardest=${jardest}"
	debug-print "sodest=${sodest}"
	debug-print "package_env=${package_env}"

}

java-pkg_do_write_()
{
	# Create directory for package.env
	dodir "${shareroot}"

	# Create package.env
	echo "DESCRIPTION=${DESCRIPTION}" > "${package_env}"
	echo "GENERATION=1" >> "${package_env}"
	if [ -n "${cp_pkg}" ]; then
		echo "CLASSPATH=${cp_prepend}:${cp_pkg}:${cp_append}" >> "${package_env}"
	fi
	if [ -n "${lp_pkg}" ]; then
		echo "LIBRARY_PATH=${lp_prepend}:${lp_pkg}:${lp_append}" >> "${package_env}"
	fi
	if [ -f ${pkglistpath} ] ; then
		pkgs=$(cat ${pkglistpath} | tr '\n' ':')
		echo "DEPEND=${pkgs}" >> "${package_env}"
	fi

	# Strip unnecessary leading and trailing colons
	sed -e "s/=:/=/" -e "s/:$//" -i "${package_env}"
}

java-pkg_do_getsrc_()
{
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
	dodir ${jardest}

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

java-pkg_newjar()
{
	if [ -z "${T}" ] || [ -z "${2}" ] ; then
		die "java-pkg_newjar: Nothing defined to do"
	fi

	rm -rf "${T}/${2}"
	cp "${1}" "${T}/${2}"
	java-pkg_dojar "${T}/${2}"
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

_record-jar()
{
	echo "$(basename $2)@$1" >> ${pkglistpath}
}

java-pkg_jarfrom() {
	java-pkg_jar-from "$@"
}

java-pkg_jar-from()
{
	debug-print-function ${FUNCNAME} $*

	local pkg=$1
	local jar=$2
	local destjar=$3

	if [ -z "${destjar}" ] ; then
		destjar=${jar}
	fi

	for x in $(java-config --classpath=${pkg} | tr ':' ' '); do
		if [ ! -f ${x} ] ; then
			die "Installation problems with jars in ${pkg} - is it installed?"
			return 1
		fi
		_record-jar ${pkg} ${x}
		if [ -z "${jar}" ] ; then
			[[ -f $(basename ${x}) ]]  && rm $(basename ${x})
			ln -snf ${x} $(basename ${x})
		elif [ "$(basename ${x})" == "${jar}" ] ; then
			[[ -f ${destjar} ]]  && rm ${destjar}
			ln -snf ${x} ${destjar}
			return 0
		fi
	done
	if [ -z "${jar}" ] ; then
		return 0
	else
		die "failed to find ${jar}"
	fi
}

java-pkg_getjar()
{

	debug-print-function ${FUNCNAME} $*

	local pkg=$1
	local jar=$2

	for x in $(java-config --classpath=${pkg} | tr ':' ' '); do

		if [ ! -f ${x} ] ; then
			die "Installation problems with jars in ${pkg} - is it installed?"
		fi

		_record-jar ${pkg} ${x}

		if [ "$(basename ${x})" == "${jar}" ] ; then
			echo ${x}
			return 0
		fi
	done
	die "Could not find $2 in $1"
}

java-pkg_getjars()
{
	java-config --classpath=$1
}


java-pkg_dohtml()
{
	dohtml -f package-list $@
}

java-pkg_jarinto()
{
	jardest=$1
}

java-pkg_sointo()
{
	sodest=$1
}

java-pkg_dosrc() {
	java-pkg_do_init_

	[ $# -lt 1 ] && die "${FUNCNAME[0]}: at least one argument needed"

	local target="${shareroot}/source/"

	local files
	local startdir=$(pwd)
	for x in ${@}; do
		cd $(dirname ${x})
		zip -q -r ${T}/${PN}-src.zip $(basename ${x}) -i '*.java'
		local res=$?
		if [[ ${res} != 12 && ${res} != 0 ]]; then
			die "zip failed"
		fi

		cd ${startdir}
	done

	dodir ${target}
	install ${INSOPTIONS} "${T}/${PN}-src.zip" "${D}${target}" \
		|| die "failed to install sources"
}


java-pkg_announce-qa-violation() {
	if hasq java-strict ${FEATURES}; then
		echo "Java QA Notice: $@" >&2
	fi
}
